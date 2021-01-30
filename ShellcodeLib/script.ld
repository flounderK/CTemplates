SECTIONS
{
	.text :
	{
		*(.text._start*)
		*(.rodata._start*)
		__start_inner_shellcode = .;
		*(.text.inner_shellcode*)
		*(.rodata.inner_shellcode*)
		*(.text*)
		__stop_inner_shellcode = .;
	}
	_end = .;
}
