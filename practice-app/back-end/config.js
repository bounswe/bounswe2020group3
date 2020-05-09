require("dotenv").config();

export default {
    port: process.env.PORT,
    databaseURL: process.env.DATABASE_CONNECTION,
    api: {
        prefix: '/api'
    }
}