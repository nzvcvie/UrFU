#include <iostream> 
#include <string> 
#include <Windows.h> 

using namespace std;

int main()
{
	setlocale(LC_ALL, "Russian");

	char* input = new char[128];
	char* output = new char[128];
	int position;
	int length_str;
	int count;

	cout << "������� ������: ";
	cin.getline(input, 128, '\n');

	cout << "\n������� �������: ";
	cin >> position;

	cout << "\n������� �����: ";
	cin >> length_str;

	cout << "\n������� ���������� ����������: ";
	cin >> count;

	_asm {
		mov ESI, input
		xor EBX, EBX

		length_string:
			mov AL, byte ptr[ESI]
			inc ESI
			inc BL
			cmp AL, 0
			jne length_string
			dec BL
			mov EAX, EBX

		// ������ � ������ ������� ����� ������ ����������� ������� � ����������� ��� �������� EAX 
		mov ECX, position
		sub EAX, ECX
		mov ECX, length_str
		sub EAX, ECX

		mov ESI, input
		mov EDI, output
		mov ECX, EBX
		mov EBX, count
		jmp copy_string

			met:
				inc eax
			copy_string:
				cmp EAX, ECX // EAX ��� ����, ����� ������ ����� ������ ������� ����� ������ ���������� 
				je copy_count
				mov DL, byte ptr[ESI]
				mov byte ptr[EDI], DL
				inc ESI
				inc EDI
				loop copy_string
				jmp finish

			copy_count:
							// ����������� � ������ ������� ����� ���������� �������� ����� ����������� 
				cmp EBX, 0  // ����� ����� �����������, �� ���������� �������� ������ 
				je met
				sub ESI, [length_str]
				mov ECX, length_str

			paste_copy:
				mov DH, byte ptr[ESI]
				mov byte ptr[EDI], DH
				inc ESI
				inc EDI
				loop paste_copy
				dec EBX // ����������� - ��������� ������� ����������� 
				mov ecx, eax
				jmp copy_count

			finish:
				mov byte ptr[EDI], 0
	}

	cout << output << endl;
	system("PAUSE");

	return 0;
}