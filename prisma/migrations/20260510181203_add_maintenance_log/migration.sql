-- CreateTable
CREATE TABLE "maintenance_log" (
    "logid" SERIAL NOT NULL,
    "assetid" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "logdate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "maintenance_log_pkey" PRIMARY KEY ("logid")
);

-- AddForeignKey
ALTER TABLE "maintenance_log" ADD CONSTRAINT "maintenance_log_assetid_fkey" FOREIGN KEY ("assetid") REFERENCES "asset"("assetid") ON DELETE NO ACTION ON UPDATE NO ACTION;
