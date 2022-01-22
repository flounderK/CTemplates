SECTIONS
{
	raw_shellcode :
	{
		*(.text._start*)
		*(.rodata._start*)
		*(.text*)
		*(.data*)
		*(.rodata*)
	}
	_end = .;
}
