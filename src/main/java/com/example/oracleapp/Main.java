package com.example.oracleapp;

import java.sql.*;

public class Main {

    private static final String URL = "jdbc:oracle:thin:@//localhost:1521/orcl";
    private static final String USER = "system";
    private static final String PASSWORD = "Tapiero123";

    public static void main(String[] args) {
        System.out.println("🚀 Iniciando inserción/actualización de aviones en Oracle 19c...");

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {

            // ejecutar el procedimiento almacenado
            CallableStatement stmt = conn.prepareCall("{call SP_GESTION_AVIONES()}");
            stmt.execute();

            System.out.println("✅ Procedimiento ejecutado correctamente.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}