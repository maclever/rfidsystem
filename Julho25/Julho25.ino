/*
//***************************************************************
Controle de acessos 21/07/2021 Luanda
Autor: Herman Figueiredo
O presente sistema tem como objectivo o controlo das entradas/saídas
em instituições de ensino.
Actualmente o sistema registra as entradas e saídas de todos utentes.
Possiveis alterações no codigo em futuras versões
//****************************************************************

Pinagem do RFID MFRC522:
SDA   Pino 59
SCK   Pino 52
MOSI  Pino 51
MISO  Pino 50
IRQ   Desconectado
GND   Pino GND
RST   Pino 49
3.3V  Pino 3.3V

Ethernet Shield: Ligado por acoplamento
Pino 4
Pino 10
Socket ICSP

Buzzer        Pino A0
Led azul      Pino 5
Led verde     Pino 6
Led vermelho  Pino 7
Relé          Pino 42
Botão Reset   Pino Reset
Botão Relé    Pino 2
*/

#include <SPI.h>
#include <Ethernet.h>
#include <MFRC522.h>

// Configuraçções de ethernet
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xE2 };    // MAC do ethernet shield, necessaria para identificar o dispositivo dentro da rede
IPAddress servidor(192, 168, 137, 1);
IPAddress gateway(192, 168, 137, 1);
IPAddress subnet(255, 255, 255, 0);
IPAddress ip(192, 168, 137, 177);                       // Ip estatico do ethernet shield

EthernetClient client;     

// Configurações de RFID
#define Pino_SDA 53
#define Pino_Reinicio 49
MFRC522 mfrc522(Pino_SDA, Pino_Reinicio);     


int buzzer = A0;              // buzzer para aviso sonoro
int led_azul = 5;             // Lez azul para stand-by
int led_verde = 6;            // Led verde para confirmação
int led_vermelho = 7;         // Led vermelho para notificar sobre qualquer erro no sistema
int rele = 42;                // Relé para representar catracas ou portas
//void requisitarBD(String& id);


void setup(){    
  pinMode(led_verde, OUTPUT);
  pinMode(led_vermelho, OUTPUT);
  pinMode(led_azul, OUTPUT);
  pinMode(rele, OUTPUT);
  pinMode(buzzer, OUTPUT);
  digitalWrite(rele, LOW);
  
  Serial.begin(9600);
  SPI.begin(); 
  mfrc522.PCD_Init();		                               // Inicialização do modulo MFRC522 (rfid)
  mfrc522.PCD_SetAntennaGain(mfrc522.RxGain_max);      //Aumento do alcance da antena para facilitar a leitura de etiquetas
    
  Ethernet.init(10);
  Ethernet.begin(mac, ip, servidor, gateway, subnet);

  delay(1000);
}

void loop(){
  digitalWrite(led_azul, HIGH);   
  if (mfrc522.PICC_IsNewCardPresent()){
    mfrc522.PICC_ReadCardSerial();
    String id = ""; 
      for (byte i = 0; i < 4; i++){
      id+=String(mfrc522.uid.uidByte[i], HEX);
      }
      Serial.println(id); 
      requisitarBD(id);
  }
}


void requisitarBD(String& id){   
  if (client.connect(servidor, 80)){   		
    String conn_php = "GET /dboard/ea/check_card.php?card_id=\""; //Verificação do cartão na base de dados
    conn_php += id;
    conn_php += "\" HTTP/1.0";
    client.println(conn_php); 
    client.println(); 
    delay(50);
    String resposta = "";
    while(true){    
      if (client.available()){    
      char ch = client.read();
      resposta += String(ch);
      //Serial.println(ch);
      }
    
      if (!client.connected()){    
        client.stop();
        break;
        }             
    }
    Serial.println(resposta); // Confirmação, a resposta do servidor irá influenciar o comportamento da catraca
    //Serial.println(resposta.endsWith(" "));
    if(resposta.endsWith("OPEN")){
      Acesso_Autorizado();    
      }
         
    if(resposta.endsWith("CLOSE")){
      Acesso_Recusado();
      }
    delay(1000);
  }
}

void avisoSonoro(){
  digitalWrite (buzzer, HIGH);  delay (25);
  digitalWrite (buzzer, LOW);   delay (25);
  digitalWrite (buzzer, HIGH);  delay (25);
  digitalWrite (buzzer, LOW);   delay (25);
}

void Acesso_Recusado(){
  digitalWrite(led_azul, LOW);
  digitalWrite(led_vermelho, HIGH); 
    tone(buzzer, 1200, 80); delay(100);
    tone(buzzer, 900, 80);  delay(100);
    tone(buzzer, 1000, 80);  delay(100);
    tone(buzzer, 300, 200); delay(200);
  digitalWrite(led_vermelho, LOW);
  digitalWrite(led_azul, HIGH);
}

void Acesso_Autorizado() {
  digitalWrite(led_azul, LOW);
    digitalWrite(led_verde, HIGH); 
    avisoSonoro();
    digitalWrite(rele, LOW);        // Abrir catraca
    delay(3000);                    // Manter aberta pelo tempo definido
    digitalWrite(rele, HIGH);       // Fechar catraca
    digitalWrite(led_verde, LOW);   // Desligar o led verde
  digitalWrite(led_azul, HIGH);     // Ligar o led azul como aviso que o sistema está em modo standby e aguarda cartões
}
