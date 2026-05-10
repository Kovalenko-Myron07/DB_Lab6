-- AlterTable
ALTER TABLE "employee" ADD COLUMN     "departmentid" INTEGER;

-- CreateTable
CREATE TABLE "department" (
    "departmentid" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,

    CONSTRAINT "department_pkey" PRIMARY KEY ("departmentid")
);

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_departmentid_fkey" FOREIGN KEY ("departmentid") REFERENCES "department"("departmentid") ON DELETE NO ACTION ON UPDATE NO ACTION;
