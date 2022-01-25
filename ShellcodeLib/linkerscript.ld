SECTIONS
{
	PROVIDE (__executable_start = SEGMENT_START("text-segment", 0x0)); . = SEGMENT_START("text-segment", 0x0);
	raw_shellcode :
	{
		_shellcode_section_start = .;
		*(.text._start*)
		*(.rodata._start*)
		*(.text*)
		_data_section_start = .;
		*(.data*)
		_data_section_end = .;
		_rodata_section_start = .;
		*(.rodata*)
		_rodata_section_end = .;
		_plt_got_section_start = .;
		*(.plt.got*)
		_plt_got_section_end = .;
		_plt_section_start = .;
		*(.plt*)
		_plt_section_end = .;
		_got_section_start = .;
		*(.got*)
		_got_section_end = .;
		_bss_section_start = .;
		*(.bss*)
		_bss_section_end = .;
		_shellcode_section_end = .;
	}
}
