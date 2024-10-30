import { connection, connect } from 'mongoose';
import { MongoMemoryServer } from 'mongodb-memory-server';

let mongoServer;

export async function connectDatabase() {
    if (connection.readyState === 1) return; // Check if already connected
    mongoServer = await MongoMemoryServer.create();
    const uri = mongoServer.getUri();
    await connect(uri);
}

export async function closeDatabase() {
    await connection.dropDatabase();
    await connection.close();
    await mongoServer.stop();
}

export async function clearDatabase() {
    const collections = connection.collections;
    for (const key in collections) {
        const collection = collections[key];
        await collection.deleteMany();
    }
}
