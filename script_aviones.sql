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

COMMIT;