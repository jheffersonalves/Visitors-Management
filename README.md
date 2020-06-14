# Visitors-Management
Sistema de Controle de Visitas em Delphi

IDE: Rad Studio 10 Seattle (Delphi)

Banco: Mysql Server
server: localhost
Database: databaselocal
user: root
password:

scripts tables:
create table cliente (
id int not null auto_increment primary key,
nome varchar(240) not null,
tipo varchar(20) not null,
documento varchar(30) not null,
telefone varchar(30) not null,
empresa_visitante varchar(40) not null
);

create table visita (
id_visita int not null auto_increment primary key,
objetivo_visita varchar(240) not null,
hora_entrada varchar(240) not null,
hora_saida varchar(240) not null,
setor_visita varchar(240) not null,
fk_visitante int not null,
foreign key (fk_visitante) references cliente(id)
)
