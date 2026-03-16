create table [Rooms] (
[RoomNumber] [nchar] (3) not null,
[Price] [smallmoney] null,
[type] [nchar] (15) null,
constraint [PK_Rooms] primary key clustered
(
[RoomNumber] asc
) with (pad_index = off, statistics_norecompute = off, ignore_dup_key = off, allow_row_locks = on,
allow_page_locks = on, optimize_for_sequential_key = off) on [primary]
) on [primary]
GO  
