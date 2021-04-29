SECTIONS
{
	raw_shellcode :
	{
		*(.text._start*)
		*(.rodata._start*)
		*(.text*)
		*(.data*)
	}
	_end = .;
}
