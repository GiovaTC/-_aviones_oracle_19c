# -_aviones_oracle_19c :.
  
Programa **Java (para IntelliJ IDEA)** que :

- Se conecta a **Oracle 19c** vía **JDBC** . 
- Ejecuta un **procedimiento almacenado (PL/SQL)** .  
- Inserta y actualiza **57 registros** en una tabla llamada `AVIONES` .

---

## 🧩 1. Estructura del proyecto Maven :

AvionesOracle19c/
├─ src/
│ └─ main/
│ ├─ java/
│ │ └─ com/example/oracleapp/
│ │ └─ Main.java
│ └─ resources/
│ └─ logo_aviones.png
└─ pom.xml

---

## ⚙️ 2. Código Java — `Main.java` :

```java
package com.example.oracleapp;

import java.sql.*;

public class Main {

    private static final String URL = "jdbc:oracle:thin:@//localhost:1521/orcl"; // Ajusta tu SID o servicio
    private static final String USER = "system";
    private static final String PASSWORD = "oracle"; // Ajusta tus credenciales

    public static void main(String[] args) {
        System.out.println("🚀 Iniciando inserción/actualización de aviones en Oracle 19c...");

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {

            // Ejecutar el procedimiento almacenado
            CallableStatement stmt = conn.prepareCall("{call SP_GESTION_AVIONES()}");
            stmt.execute();

            System.out.println("✅ Procedimiento ejecutado correctamente.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

🧠 3. Script SQL — Crear tabla y procedimiento :
Guarda esto en un archivo aviones.sql y ejecútalo desde SQL*Plus o SQL Developer con tu usuario Oracle :

-- ==========================================
-- CREAR TABLA DE AVIONES
-- ==========================================
CREATE TABLE AVIONES (
    ID_AVION NUMBER PRIMARY KEY,
    MODELO VARCHAR2(50),
    FABRICANTE VARCHAR2(50),
    CAPACIDAD NUMBER,
    ESTADO VARCHAR2(20)
);

-- ==========================================
-- CREAR PROCEDIMIENTO PARA INSERTAR Y ACTUALIZAR
-- ==========================================
CREATE OR REPLACE PROCEDURE SP_GESTION_AVIONES AS
BEGIN
    FOR i IN 1..57 LOOP
        BEGIN
            INSERT INTO AVIONES (ID_AVION, MODELO, FABRICANTE, CAPACIDAD, ESTADO)
            VALUES (
                i,
                'Modelo-' || i,
                'Fabricante-' || MOD(i,5),
                100 + i,
                CASE WHEN MOD(i,2)=0 THEN 'Activo' ELSE 'Mantenimiento' END
            );
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                UPDATE AVIONES
                SET
                    MODELO = 'Modelo-Actualizado-' || i,
                    ESTADO = 'Revisado'
                WHERE ID_AVION = i;
        END;
    END LOOP;

    COMMIT;
END SP_GESTION_AVIONES;
/

📘 Explicación rápida
Inserta 57 registros (del 1 al 57) .

Si el ID ya existe, actualiza el modelo y el estado .

Usa DUP_VAL_ON_INDEX para detectar duplicados automáticamente .

🧩 4. Archivo pom.xml (para Maven) :

<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>AvionesOracle19c</artifactId>
    <version>1.0-SNAPSHOT</version>

    <dependencies>
        <!-- JDBC Oracle -->
        <dependency>
            <groupId>com.oracle.database.jdbc</groupId>
            <artifactId>ojdbc8</artifactId>
            <version>23.2.0.0</version>
        </dependency>
    </dependencies>

</project>

📘 5. Guía rápida de uso :  
⚙️ Configurar credenciales en Main.java:

private static final String URL = "jdbc:oracle:thin:@//localhost:1521/orcl";
private static final String USER = "system";
private static final String PASSWORD = "oracle";

▶️ Ejecutar el programa desde IntelliJ o terminal :

mvn compile exec:java -Dexec.mainClass="com.example.oracleapp.Main"
🔍 Verificar la tabla en Oracle :

SELECT * FROM AVIONES;

📦 Dependencias .
☕ Java 21

🧱 Maven 3.9.9 o superior

🗄️ Oracle Database 19c

🔌 Oracle JDBC (ojdbc8)
```
🎨 Logo del proyecto

<img width="1024" height="1024" alt="image" src="https://github.com/user-attachments/assets/6734aecd-7ae1-4f84-a439-45974bab07c8" /> .

👨‍💻 Autor
Giovanny Alejandro Tapiero Cataño
Proyecto académico — Arquitectura Octagonal + Oracle 19c
2025 :.
