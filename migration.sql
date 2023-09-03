/*
  Warnings:

  - The primary key for the `Mae` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `CPF` on the `Mae` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - You are about to drop the column `maenome` on the `Bebe` table. All the data in the column will be lost.
  - You are about to drop the column `mednome` on the `Bebe` table. All the data in the column will be lost.
  - The primary key for the `Medico` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `CRM` on the `Medico` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - Added the required column `maeCPF` to the `Bebe` table without a default value. This is not possible if the table is not empty.
  - Added the required column `medCRM` to the `Bebe` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Mae" (
    "nomemae" TEXT NOT NULL,
    "CPF" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "data_nasc" DATETIME NOT NULL,
    "endereco" TEXT NOT NULL,
    "telefone" TEXT NOT NULL
);
INSERT INTO "new_Mae" ("CPF", "data_nasc", "endereco", "nomemae", "telefone") SELECT "CPF", "data_nasc", "endereco", "nomemae", "telefone" FROM "Mae";
DROP TABLE "Mae";
ALTER TABLE "new_Mae" RENAME TO "Mae";
CREATE UNIQUE INDEX "Mae_CPF_key" ON "Mae"("CPF");
CREATE UNIQUE INDEX "Mae_telefone_key" ON "Mae"("telefone");
CREATE TABLE "new_Bebe" (
    "nome" TEXT NOT NULL,
    "CPF" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "data_nasc" DATETIME NOT NULL,
    "peso_nasc" REAL NOT NULL,
    "altura" REAL NOT NULL,
    "maeCPF" INTEGER NOT NULL,
    "medCRM" INTEGER NOT NULL,
    CONSTRAINT "Bebe_maeCPF_fkey" FOREIGN KEY ("maeCPF") REFERENCES "Mae" ("CPF") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Bebe_medCRM_fkey" FOREIGN KEY ("medCRM") REFERENCES "Medico" ("CRM") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Bebe" ("CPF", "altura", "data_nasc", "nome", "peso_nasc") SELECT "CPF", "altura", "data_nasc", "nome", "peso_nasc" FROM "Bebe";
DROP TABLE "Bebe";
ALTER TABLE "new_Bebe" RENAME TO "Bebe";
CREATE UNIQUE INDEX "Bebe_CPF_key" ON "Bebe"("CPF");
CREATE TABLE "new_Medico" (
    "nomemedico" TEXT NOT NULL,
    "CRM" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "data_nasc" DATETIME NOT NULL,
    "especialidade" TEXT NOT NULL
);
INSERT INTO "new_Medico" ("CRM", "data_nasc", "especialidade", "nomemedico") SELECT "CRM", "data_nasc", "especialidade", "nomemedico" FROM "Medico";
DROP TABLE "Medico";
ALTER TABLE "new_Medico" RENAME TO "Medico";
CREATE UNIQUE INDEX "Medico_CRM_key" ON "Medico"("CRM");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
