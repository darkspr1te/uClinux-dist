
MEMORY {
	ram    : ORIGIN = 0x10000, LENGTH = 0xf0000
}

SECTIONS {

	.text : {
		_stext = . ;
        	*(.text)
			*(.text.exit)
			*(.text.lock)
			*(.exitcall.exit)
			*(.rodata)
		. = ALIGN(0x4) ;
			*(.kstrtab)
		. = ALIGN(16);          /* Exception table              */
		__start___ex_table = .;
			*(__ex_table)
		__stop___ex_table = .;

		__start___ksymtab = .;  /* Kernel symbol table          */
			*(__ksymtab)
		__stop___ksymtab = .;
		. = ALIGN(4) ;
		_etext = . ;
	} > ram

	.data BLOCK(0x4) : {
		_sdata = . ;
		__data_start = . ;
        	*(.data)
			*(.data.exit)
		. = ALIGN(0x2000) ;
        	*(.data.init_task)
		. = ALIGN(0x2000) ;
		_edata = . ;
	} > ram

	.init BLOCK(4096) : {
		__init_begin = .;
			*(.text.init)
			*(.data.init)
		. = ALIGN(16);
		__setup_start = .;
			*(.setup.init)
		__setup_end = .;
		__initcall_start = .;
			*(.initcall.init)
		. = ALIGN(4) ;
		__initcall_end = .;
		__init_end = .;
	} > ram

	.bss BLOCK(0x4) : {
		_sbss = . ;
			*(.bss)
			*(COMMON)
		. = ALIGN(4) ;
		_ebss = . ;
		_end = . ;
	} > ram
}

