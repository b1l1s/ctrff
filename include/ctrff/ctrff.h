#ifndef __CTRFF_H
#define __CTRFF_H

#include <inttypes.h>
#include <stddef.h>

typedef struct ctrff_nand_ctx
{
	uint32_t(*toRaw)(void* data, uint32_t sector);

	uint32_t(*decrypt)(void* data, void* buffer, uint32_t sector, size_t count);
	uint32_t(*encrypt)(void* data, void* buffer, uint32_t sector, size_t count);

	void* data;
} ctrff_nand_ctx;

uint32_t ctrff_init(void*(*alloc)(size_t));
uint32_t ctrff_nand_mount(const ctrff_nand_ctx* ctx);
uint32_t ctrff_nand_read(void* buffer, uint32_t sector, size_t count);
uint32_t ctrff_nand_write(const void* buffer, uint32_t sector, size_t count);

uint32_t ctrff_emunand_mount(const ctrff_nand_ctx* ctx);
uint32_t ctrff_emunand_read(void* buffer, uint32_t sector, size_t count);
uint32_t ctrff_emunand_write(const void* buffer, uint32_t sector, size_t count);

#endif /*__CTRFF_H*/
