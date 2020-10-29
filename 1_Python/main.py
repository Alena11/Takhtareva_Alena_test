import xlrd

wb = xlrd.open_workbook('report.xls').sheet_by_name('Лист2')
n = wb.nrows
m = wb.ncols
data = [[''] * m for i in range(n)]

for i in range(n):
    for j in range(m):
        data[i][j] = wb.cell(i, j).value

fraction = data[0][3]
flag = False
result = ''

for i in range(n):
    if (data[i][3] == fraction) and (data[i][6] == 'Отказ в регистрации'):
        result = result + ' ' + data[i][4]

if result == '':
    print('Нет округов без представителей КПРФ.')
else:
    print('Округ №:', result)
