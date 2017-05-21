/**************************************** * SKRYPT TWORZACY BAZE DANYCH PRZYCHODNIA
*****************************************/
/*
GO
USE MASTER;
DROP DATABASE IF EXISTS PRZYCHODNIA;
GO
CREATE DATABASE PRZYCHODNIA;
GO
USE PRZYCHODNIA;
*/
GO
DROP TABLE IF EXISTS PLACOWKA;
DROP TABLE IF EXISTS LEKARZ;
DROP TABLE IF EXISTS WIZYTA;
DROP TABLE IF EXISTS RECEPTA;
DROP TABLE IF EXISTS PACJENT;
DROP TABLE IF EXISTS DYZUR;
DROP TABLE IF EXISTS SALA;
ALTER TABLE ODDZIAL_PRACOWNIK DROP CONSTRAINT IF EXISTS fk_ODDZIAL_PRACOWNIK_ID_PRACOWNIK;
ALTER TABLE ODDZIAL_PRACOWNIK DROP CONSTRAINT IF EXISTS fk_ODDZIAL_PRACOWNIK_ID_ODDZIAL;
DROP TABLE IF EXISTS PRACOWNIK;
DROP TABLE IF EXISTS ODDZIAL_PRACOWNIK;
DROP TABLE IF EXISTS SPECJALIZACJA;
DROP TABLE IF EXISTS ODDZIAL;
GO/*
* DEFINICJE TABEL
*/CREATE TABLE ODDZIAL (
    ID_ODDZIAL INT NOT NULL
   ,NAZWA VARCHAR(255)
   ,MIEJSCOWOSC VARCHAR(255)
    ,CONSTRAINT pk_ODDZIAL_ID_ODDZIAL PRIMARY KEY(ID_ODDZIAL)
);CREATE TABLE SALA (
    ID_SALA INT NOT NULL
   ,NUMER_SALI INT
    ,CONSTRAINT pk_SALA_ID_SALA PRIMARY KEY(ID_SALA)
);CREATE TABLE SPECJALIZACJA (
    ID_SPECJALIZACJA INT NOT NULL
   ,SPECJALIZACJA VARCHAR(255)
   ,NAZWISKO VARCHAR(255)
    ,CONSTRAINT pk_SPECJALIZACJA_ID_SPECJALIZACJA PRIMARY KEY(ID_SPECJALIZACJA)
);CREATE TABLE PLACOWKA (
    ID_PLACOWKA INT NOT NULL
   ,NAZWA VARCHAR(255)
   ,MIEJSCOWOSC VARCHAR(255)
   ,ID_ODDZIAL INT
    ,CONSTRAINT pk_PLACOWKA_ID_PLACOWKA PRIMARY KEY(ID_PLACOWKA)
);CREATE TABLE DYZUR (
    ID_PRACOWNIK INT NOT NULL
   ,DZIEN_DYZURU DATE
   ,OD DATE
   ,DO DATE
   ,ID_ODDZIAL INT
);CREATE TABLE RECEPTA (
    ID_RECEPTA INT NOT NULL
   ,UWAGI VARCHAR(255)
    ,CONSTRAINT pk_RECEPTY_ID_RECEPTA PRIMARY KEY(ID_RECEPTA)
);CREATE TABLE PACJENT (
    ID_PACJENT INT NOT NULL
   ,IMIE VARCHAR(255)
    ,NAZWISKO VARCHAR(255)
    ,ADRES VARCHAR(255)
    ,CONSTRAINT pk_PACJENT_ID_PACJENT PRIMARY KEY(ID_PACJENT)
);CREATE TABLE PRACOWNIK (
    ID_PRACOWNIK INT NOT NULL
   ,IMIE VARCHAR(255)
   ,NAZWISKO VARCHAR (255)
   ,ID_SPECJALIZACJA INT
   ,ID_ODDZIAL_PRACOWNIK INT
    ,CONSTRAINT pk_PRACOWNIK_ID_PRACOWNIK PRIMARY KEY(ID_PRACOWNIK)
);CREATE TABLE ODDZIAL_PRACOWNIK (
    ID_ODDZIAL_PRACOWNIK INT NOT NULL
  ,ID_PRACOWNIK INT  
  ,ID_ODDZIAL INT
  ,CONSTRAINT pk_ODDZIAL_PRACOWNIK_ID_ODDZIAL_PRACOWNIK PRIMARY KEY(ID_ODDZIAL_PRACOWNIK)
);CREATE TABLE WIZYTA (
    ID_WIZYTA INT NOT NULL
   ,DATA_WIZYTY DATE
   ,ID_SALA INT
   ,ID_PRACOWNIK INT
   ,ID_ODDZIAL INT
   ,ID_PACJENT INT
   ,ID_RECEPTA INT
   ,UWAGI VARCHAR(255)
    ,CONSTRAINT pk_WIZYTA_ID_WIZYTA PRIMARY KEY(ID_WIZYTA)
);/*
* OGRANICZENIA
*/ALTER TABLE PLACOWKA
ADD CONSTRAINT fk_PLACOWKA_ID_ODDZIAL FOREIGN KEY(ID_ODDZIAL) REFERENCES ODDZIAL(ID_ODDZIAL);ALTER TABLE PRACOWNIK
ADD CONSTRAINT fk_PRACOWNIK_ID_SPECJALIZACJA FOREIGN KEY(ID_SPECJALIZACJA) REFERENCES SPECJALIZACJA(ID_SPECJALIZACJA),
    CONSTRAINT fk_PRACOWNIK_ID_ODDZIAL_PRACOWNIK FOREIGN KEY(ID_ODDZIAL_PRACOWNIK) REFERENCES ODDZIAL_PRACOWNIK(ID_ODDZIAL_PRACOWNIK);ALTER TABLE ODDZIAL_PRACOWNIK
ADD CONSTRAINT fk_ODDZIAL_PRACOWNIK_ID_PRACOWNIK FOREIGN KEY(ID_PRACOWNIK) REFERENCES PRACOWNIK(ID_PRACOWNIK),
    CONSTRAINT fk_ODDZIAL_PRACOWNIK_ID_ODDZIAL FOREIGN KEY(ID_ODDZIAL) REFERENCES ODDZIAL(ID_ODDZIAL);ALTER TABLE WIZYTA
ADD CONSTRAINT fk_WIZYTA_ID_SALA FOREIGN KEY(ID_SALA) REFERENCES SALA(ID_SALA),
    CONSTRAINT fk_WIZYTA_ID_PRACOWNIK FOREIGN KEY(ID_PRACOWNIK) REFERENCES PRACOWNIK(ID_PRACOWNIK),
    CONSTRAINT fk_WIZYTA_ID_ODDZIAL FOREIGN KEY(ID_ODDZIAL) REFERENCES ODDZIAL(ID_ODDZIAL),
    CONSTRAINT fk_WIZYTA_ID_PRACJENT FOREIGN KEY(ID_PACJENT) REFERENCES PACJENT(ID_PACJENT),
    CONSTRAINT fk_WIZYTA_ID_RECEPTA FOREIGN KEY(ID_RECEPTA) REFERENCES RECEPTA(ID_RECEPTA); ALTER TABLE DYZUR
ADD CONSTRAINT fk_DYZUR_ID_PRACOWNIK FOREIGN KEY(ID_PRACOWNIK) REFERENCES PRACOWNIK(ID_PRACOWNIK),
    CONSTRAINT fk_DYZUR_ID_ODDZIAL FOREIGN KEY(ID_ODDZIAL) REFERENCES ODDZIAL(ID_ODDZIAL);
