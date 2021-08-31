import asyncio
from time import sleep


async def main():
    print("starting")
    await asyncio.sleep(5)
    print("ending")


print("async io start")

asyncio.run(main())

print("async io end")
