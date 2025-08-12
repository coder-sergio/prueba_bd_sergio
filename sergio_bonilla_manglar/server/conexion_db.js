import { Pool } from "pg";

export const pool = new Pool({
    database:"pd_sergio_bonilla_manglar",
    host:"localhost",
    port:5432,
    user:"sergio",
    password:"Qwe.123*"
})


async function probarConexionConLaBaseDeDatos() {
    try {
        const connection = await pool.connect();
        console.log('✅ Conexión a la base de datos exitosa');
        connection.release();
    } catch (error) {
        console.error('❌ Error al conectar con la base de datos:', error.message);
    }
}

probarConexionConLaBaseDeDatos();