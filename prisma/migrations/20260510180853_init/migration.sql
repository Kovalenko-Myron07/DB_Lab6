-- CreateTable
CREATE TABLE "asset" (
    "assetid" INTEGER NOT NULL,
    "inventorynumber" VARCHAR(50) NOT NULL,
    "assetname" VARCHAR(200) NOT NULL,
    "price" DECIMAL(10,2),
    "categoryid" INTEGER NOT NULL,

    CONSTRAINT "asset_pkey" PRIMARY KEY ("assetid")
);

-- CreateTable
CREATE TABLE "asset_allocation" (
    "allocationid" INTEGER NOT NULL,
    "assetid" INTEGER NOT NULL,
    "employeeid" INTEGER NOT NULL,
    "roomid" INTEGER NOT NULL,
    "issuedate" DATE NOT NULL,
    "returndate" DATE,

    CONSTRAINT "asset_allocation_pkey" PRIMARY KEY ("allocationid")
);

-- CreateTable
CREATE TABLE "category" (
    "categoryid" INTEGER NOT NULL,
    "categoryname" VARCHAR(100) NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("categoryid")
);

-- CreateTable
CREATE TABLE "employee" (
    "employeeid" INTEGER NOT NULL,
    "fullname" VARCHAR(150) NOT NULL,
    "position" VARCHAR(100) NOT NULL,

    CONSTRAINT "employee_pkey" PRIMARY KEY ("employeeid")
);

-- CreateTable
CREATE TABLE "room" (
    "roomid" INTEGER NOT NULL,
    "roomnumber" VARCHAR(20) NOT NULL,
    "roomname" VARCHAR(100) NOT NULL,

    CONSTRAINT "room_pkey" PRIMARY KEY ("roomid")
);

-- CreateIndex
CREATE UNIQUE INDEX "asset_inventorynumber_key" ON "asset"("inventorynumber");

-- AddForeignKey
ALTER TABLE "asset" ADD CONSTRAINT "asset_categoryid_fkey" FOREIGN KEY ("categoryid") REFERENCES "category"("categoryid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "asset_allocation" ADD CONSTRAINT "asset_allocation_assetid_fkey" FOREIGN KEY ("assetid") REFERENCES "asset"("assetid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "asset_allocation" ADD CONSTRAINT "asset_allocation_employeeid_fkey" FOREIGN KEY ("employeeid") REFERENCES "employee"("employeeid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "asset_allocation" ADD CONSTRAINT "asset_allocation_roomid_fkey" FOREIGN KEY ("roomid") REFERENCES "room"("roomid") ON DELETE NO ACTION ON UPDATE NO ACTION;
