// ����� ���������� ��������� ������� � ������

#include <iostream> 
#define SIZE 22 

using namespace std;

extern "C" 
void *setString()
{
	cout << "������� ������ (�� 22 ��������): ";

	char* str = new char[SIZE];
	cin.getline(str, 82, '\n');

	if (strlen(str) > SIZE)
	{
		cout << "����� �� �������\n";
		system("PAUSE");
		exit(1);
	}

	return str;
}

extern "C"
char setSymbol()
{
	cout << "������� ������� ������: ";
	char symbol;
	cin >> symbol;

	return symbol;
}

extern "C" 
void lineSearch(char *str, char symbol) {
	int enters = 0;

	for (int i = 0; i < SIZE; i++)
	{
		if (str[i] == symbol)
			enters++;
	}

	if (enters <= 4 && enters > 1)
	{
		cout << enters << " ���������\n";
	}

	if (enters == 1)
	{
		cout << enters << " ���������\n";
	}

	if (enters >= 5 || enters == 0)
	{
		cout << enters << " ���������\n";
	}

}

void main()
{
	setlocale(LC_ALL, "Russian");

	_asm {
		call setString
		mov ESI, EAX
		call setSymbol

		push EAX
		push ESI

		call lineSearch
		pop ESI
		pop EAX
	}

	system("PAUSE");
}