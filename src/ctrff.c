#include "ff.h"
#include <inttypes.h>
#include <string.h>
#include "diskio.h"
#include "ctr/printf.h"

#include "ctrff.h"

static ctrff_nand_ctx nand_ctx;
static ctrff_nand_ctx emunand_ctx;

typedef struct ctrff_s
{
	FATFS fs[3];
} ctrff_s;

ctrff_s* ctrff;

uint32_t ctrff_init(void*(*alloc)(size_t))
{
	DRESULT res = RES_PARERR;

	ctrff = (ctrff_s*) alloc(sizeof(ctrff_s));
	if(ctrff)
	{
		memset(ctrff, 0, sizeof(ctrff_s));
		res = f_mount(&ctrff->fs[0], "sdmc:", 1);
	}

	return res;
}

uint32_t ctrff_nand_mount(const ctrff_nand_ctx* ctx)
{
	memcpy(&nand_ctx, ctx, sizeof(ctrff_nand_ctx));

	return f_mount(&ctrff->fs[1], "nand:", 1);
}

uint32_t ctrff_nand_read(void* buffer, uint32_t sector, size_t count)
{
	DRESULT res = RES_PARERR;

	if(nand_ctx.toRaw && nand_ctx.decrypt)
	{
		uint32_t rawSector = nand_ctx.toRaw(nand_ctx.data, sector);

		res = sdmmc_nand_readsectors(rawSector, count, buffer);
		if(res == RES_OK)
			nand_ctx.decrypt(nand_ctx.data, buffer, rawSector, count);
	}

	return res;
}

uint32_t ctrff_nand_write(const void* buffer, uint32_t sector, size_t count)
{
	DRESULT res = RES_PARERR;

	if(nand_ctx.toRaw && nand_ctx.encrypt)
	{
		//uint32_t rawSector = nand_ctx.toRaw(nand_ctx.data, sector);

		//nand_ctx.encrypt(nand_ctx.data, buffer, sector, count);
		//res = sdmmc_nand_writesectors(rawSector, count, buffer);
	}

	return res;
}

uint32_t ctrff_emunand_mount(const ctrff_nand_ctx* ctx)
{
	memcpy(&emunand_ctx, ctx, sizeof(ctrff_nand_ctx));

	return f_mount(&ctrff->fs[2], "emu0:", 1);
}

uint32_t ctrff_emunand_read(void* buffer, uint32_t sector, size_t count)
{
	DRESULT res = RES_PARERR;

	if(emunand_ctx.toRaw && emunand_ctx.decrypt)
	{
		uint32_t rawSector = emunand_ctx.toRaw(emunand_ctx.data, sector);

		res = sdmmc_sdcard_readsectors(rawSector, count, buffer);
		if(res == RES_OK)
			emunand_ctx.decrypt(emunand_ctx.data, buffer, rawSector, count);
	}

	return res;
}

uint32_t ctrff_emunand_write(const void* buffer, uint32_t sector, size_t count)
{
	DRESULT res = RES_PARERR;

	if(emunand_ctx.toRaw && emunand_ctx.encrypt)
	{
		//uint32_t rawSector = emunand_ctx.toRaw(emunand_ctx.data, sector);

		//emunand_ctx.encrypt(emunand_ctx.data, buffer, rawSector, count);
		//res = sdmmc_sdcard_writesectors(rawSector, count, buffer);
	}

	return res;
}
