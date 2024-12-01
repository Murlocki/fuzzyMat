import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
from matplotlib import pyplot as plt

n = 0.00001
# Создание входных переменных
interest_rate = ctrl.Antecedent(np.arange(0, 20, n), 'InterestRate')  # 0-10 для процентной ставки
fees = ctrl.Antecedent(np.arange(0, 10, n), 'Fees')  # 0-10 для комиссии
loan_term = ctrl.Antecedent(np.arange(0, 30, n), 'LoanTerm')  # 0-10 для срока кредита
bank_reputation = ctrl.Antecedent(np.arange(0, 10, n), 'BankReputation')  # 0-10 для репутации банка

# Создание выходной переменной
bank_score = ctrl.Consequent(np.arange(0, 10, n), 'BankScore')  # Оценка банка (0-10)

# Определение нечетких функций принадлежности для входных переменных
interest_rate['low'] = fuzz.trapmf(interest_rate.universe, [0, 0, 2, 5])
interest_rate['medium'] = fuzz.trimf(interest_rate.universe, [4, 7, 10])
interest_rate['high'] = fuzz.trapmf(interest_rate.universe, [9, 12, 20, 20])

fees['low'] = fuzz.trapmf(fees.universe, [0, 0, 1, 2])
fees['medium'] = fuzz.trimf(fees.universe, [1, 3, 5])
fees['high'] = fuzz.trapmf(fees.universe, [4, 6, 10, 10])

loan_term['short'] = fuzz.trapmf(loan_term.universe, [0, 0, 2, 5])
loan_term['medium'] = fuzz.trimf(loan_term.universe, [3, 8, 15])
loan_term['long'] = fuzz.trapmf(loan_term.universe, [10, 20, 30, 30])

bank_reputation['low'] = fuzz.trapmf(bank_reputation.universe, [0, 0, 2, 3])
bank_reputation['medium'] = fuzz.trimf(bank_reputation.universe, [2, 5, 7])
bank_reputation['high'] = fuzz.trapmf(bank_reputation.universe, [6, 8, 10, 10])

# Определение нечетких функций принадлежности для выходной переменной
bank_score['bad'] = fuzz.trapmf(bank_score.universe, [0, 0, 2, 3])
bank_score['average'] = fuzz.trimf(bank_score.universe, [2, 5, 7])
bank_score['good'] = fuzz.trapmf(bank_score.universe, [5, 8, 10, 10])

# Правила
rules = [0 for i in range(81)]
rules[0] = ctrl.Rule(interest_rate['low'] & fees['low'] & loan_term['short'] & bank_reputation['low'], bank_score['good'])
rules[1] = ctrl.Rule(interest_rate['low'] & fees['low'] & loan_term['short'] & bank_reputation['medium'], bank_score['good'])
rules[2] = ctrl.Rule(interest_rate['low'] & fees['low'] & loan_term['short'] & bank_reputation['high'], bank_score['good'])
rules[3] = ctrl.Rule(interest_rate['low'] & fees['low'] & loan_term['medium'] & bank_reputation['low'], bank_score['good'])
rules[4] = ctrl.Rule(interest_rate['low'] & fees['low'] & loan_term['medium'] & bank_reputation['medium'], bank_score['good'])
rules[5] = ctrl.Rule(interest_rate['low'] & fees['low'] & loan_term['medium'] & bank_reputation['high'], bank_score['good'])
rules[6] = ctrl.Rule(interest_rate['low'] & fees['low'] & loan_term['long'] & bank_reputation['low'], bank_score['average'])
rules[7] = ctrl.Rule(interest_rate['low'] & fees['low'] & loan_term['long'] & bank_reputation['medium'], bank_score['good'])
rules[8] = ctrl.Rule(interest_rate['low'] & fees['low'] & loan_term['long'] & bank_reputation['high'], bank_score['good'])
rules[9] = ctrl.Rule(interest_rate['low'] & fees['medium'] & loan_term['short'] & bank_reputation['low'], bank_score['good'])
rules[10] = ctrl.Rule(interest_rate['low'] & fees['medium'] & loan_term['short'] & bank_reputation['medium'], bank_score['good'])
rules[11] = ctrl.Rule(interest_rate['low'] & fees['medium'] & loan_term['short'] & bank_reputation['high'], bank_score['good'])
rules[12] = ctrl.Rule(interest_rate['low'] & fees['medium'] & loan_term['medium'] & bank_reputation['low'], bank_score['good'])
rules[13] = ctrl.Rule(interest_rate['low'] & fees['medium'] & loan_term['medium'] & bank_reputation['medium'], bank_score['good'])
rules[14] = ctrl.Rule(interest_rate['low'] & fees['medium'] & loan_term['medium'] & bank_reputation['high'], bank_score['good'])
rules[15] = ctrl.Rule(interest_rate['low'] & fees['medium'] & loan_term['long'] & bank_reputation['low'], bank_score['average'])
rules[16] = ctrl.Rule(interest_rate['low'] & fees['medium'] & loan_term['long'] & bank_reputation['medium'], bank_score['good'])
rules[17] = ctrl.Rule(interest_rate['low'] & fees['medium'] & loan_term['long'] & bank_reputation['high'], bank_score['good'])
rules[18] = ctrl.Rule(interest_rate['low'] & fees['high'] & loan_term['short'] & bank_reputation['low'], bank_score['average'])
rules[19] = ctrl.Rule(interest_rate['low'] & fees['high'] & loan_term['short'] & bank_reputation['medium'], bank_score['average'])
rules[20] = ctrl.Rule(interest_rate['low'] & fees['high'] & loan_term['short'] & bank_reputation['high'], bank_score['good'])
rules[21] = ctrl.Rule(interest_rate['low'] & fees['high'] & loan_term['medium'] & bank_reputation['low'], bank_score['average'])
rules[22] = ctrl.Rule(interest_rate['low'] & fees['high'] & loan_term['medium'] & bank_reputation['medium'], bank_score['average'])
rules[23] = ctrl.Rule(interest_rate['low'] & fees['high'] & loan_term['medium'] & bank_reputation['high'], bank_score['good'])
rules[24] = ctrl.Rule(interest_rate['low'] & fees['high'] & loan_term['long'] & bank_reputation['low'], bank_score['average'])
rules[25] = ctrl.Rule(interest_rate['low'] & fees['high'] & loan_term['long'] & bank_reputation['medium'], bank_score['average'])
rules[26] = ctrl.Rule(interest_rate['low'] & fees['high'] & loan_term['long'] & bank_reputation['high'], bank_score['good'])

rules[27] = ctrl.Rule(interest_rate['medium'] & fees['low'] & loan_term['short'] & bank_reputation['low'], bank_score['average'])
rules[28] = ctrl.Rule(interest_rate['medium'] & fees['low'] & loan_term['short'] & bank_reputation['medium'], bank_score['good'])
rules[29] = ctrl.Rule(interest_rate['medium'] & fees['low'] & loan_term['short'] & bank_reputation['high'], bank_score['good'])
rules[30] = ctrl.Rule(interest_rate['medium'] & fees['low'] & loan_term['medium'] & bank_reputation['low'], bank_score['good'])
rules[31] = ctrl.Rule(interest_rate['medium'] & fees['low'] & loan_term['medium'] & bank_reputation['medium'], bank_score['good'])
rules[32] = ctrl.Rule(interest_rate['medium'] & fees['low'] & loan_term['medium'] & bank_reputation['high'], bank_score['good'])
rules[33] = ctrl.Rule(interest_rate['medium'] & fees['low'] & loan_term['long'] & bank_reputation['low'], bank_score['average'])
rules[34] = ctrl.Rule(interest_rate['medium'] & fees['low'] & loan_term['long'] & bank_reputation['medium'], bank_score['good'])
rules[35] = ctrl.Rule(interest_rate['medium'] & fees['low'] & loan_term['long'] & bank_reputation['high'], bank_score['good'])
rules[36] = ctrl.Rule(interest_rate['medium'] & fees['medium'] & loan_term['short'] & bank_reputation['low'], bank_score['average'])
rules[37] = ctrl.Rule(interest_rate['medium'] & fees['medium'] & loan_term['short'] & bank_reputation['medium'], bank_score['good'])
rules[38] = ctrl.Rule(interest_rate['medium'] & fees['medium'] & loan_term['short'] & bank_reputation['high'], bank_score['good'])
rules[39] = ctrl.Rule(interest_rate['medium'] & fees['medium'] & loan_term['medium'] & bank_reputation['low'], bank_score['good'])
rules[40] = ctrl.Rule(interest_rate['medium'] & fees['medium'] & loan_term['medium'] & bank_reputation['medium'], bank_score['good'])
rules[41] = ctrl.Rule(interest_rate['medium'] & fees['medium'] & loan_term['medium'] & bank_reputation['high'], bank_score['good'])
rules[42] = ctrl.Rule(interest_rate['medium'] & fees['medium'] & loan_term['long'] & bank_reputation['low'], bank_score['average'])
rules[43] = ctrl.Rule(interest_rate['medium'] & fees['medium'] & loan_term['long'] & bank_reputation['medium'], bank_score['good'])
rules[44] = ctrl.Rule(interest_rate['medium'] & fees['medium'] & loan_term['long'] & bank_reputation['high'], bank_score['good'])
rules[45] = ctrl.Rule(interest_rate['medium'] & fees['high'] & loan_term['short'] & bank_reputation['low'], bank_score['average'])
rules[46] = ctrl.Rule(interest_rate['medium'] & fees['high'] & loan_term['short'] & bank_reputation['medium'], bank_score['average'])
rules[47] = ctrl.Rule(interest_rate['medium'] & fees['high'] & loan_term['short'] & bank_reputation['high'], bank_score['good'])
rules[48] = ctrl.Rule(interest_rate['medium'] & fees['high'] & loan_term['medium'] & bank_reputation['low'], bank_score['average'])
rules[49] = ctrl.Rule(interest_rate['medium'] & fees['high'] & loan_term['medium'] & bank_reputation['medium'], bank_score['average'])
rules[50] = ctrl.Rule(interest_rate['medium'] & fees['high'] & loan_term['medium'] & bank_reputation['high'], bank_score['good'])
rules[51] = ctrl.Rule(interest_rate['medium'] & fees['high'] & loan_term['long'] & bank_reputation['low'], bank_score['average'])
rules[52] = ctrl.Rule(interest_rate['medium'] & fees['high'] & loan_term['long'] & bank_reputation['medium'], bank_score['average'])
rules[53] = ctrl.Rule(interest_rate['medium'] & fees['high'] & loan_term['long'] & bank_reputation['high'], bank_score['good'])

rules[54] = ctrl.Rule(interest_rate['high'] & fees['low'] & loan_term['short'] & bank_reputation['low'], bank_score['bad'])
rules[55] = ctrl.Rule(interest_rate['high'] & fees['low'] & loan_term['short'] & bank_reputation['medium'], bank_score['average'])
rules[56] = ctrl.Rule(interest_rate['high'] & fees['low'] & loan_term['short'] & bank_reputation['high'], bank_score['average'])
rules[57] = ctrl.Rule(interest_rate['high'] & fees['low'] & loan_term['medium'] & bank_reputation['low'], bank_score['bad'])
rules[58] = ctrl.Rule(interest_rate['high'] & fees['low'] & loan_term['medium'] & bank_reputation['medium'], bank_score['average'])
rules[59] = ctrl.Rule(interest_rate['high'] & fees['low'] & loan_term['medium'] & bank_reputation['high'], bank_score['average'])
rules[60] = ctrl.Rule(interest_rate['high'] & fees['low'] & loan_term['long'] & bank_reputation['low'], bank_score['bad'])
rules[61] = ctrl.Rule(interest_rate['high'] & fees['low'] & loan_term['long'] & bank_reputation['medium'], bank_score['average'])
rules[62] = ctrl.Rule(interest_rate['high'] & fees['low'] & loan_term['long'] & bank_reputation['high'], bank_score['average'])
rules[63] = ctrl.Rule(interest_rate['high'] & fees['medium'] & loan_term['short'] & bank_reputation['low'], bank_score['bad'])
rules[64] = ctrl.Rule(interest_rate['high'] & fees['medium'] & loan_term['short'] & bank_reputation['medium'], bank_score['average'])
rules[65] = ctrl.Rule(interest_rate['high'] & fees['medium'] & loan_term['short'] & bank_reputation['high'], bank_score['average'])
rules[66] = ctrl.Rule(interest_rate['high'] & fees['medium'] & loan_term['medium'] & bank_reputation['low'], bank_score['bad'])
rules[67] = ctrl.Rule(interest_rate['high'] & fees['medium'] & loan_term['medium'] & bank_reputation['medium'], bank_score['average'])
rules[68] = ctrl.Rule(interest_rate['high'] & fees['medium'] & loan_term['medium'] & bank_reputation['high'], bank_score['average'])
rules[69] = ctrl.Rule(interest_rate['high'] & fees['medium'] & loan_term['long'] & bank_reputation['low'], bank_score['bad'])
rules[70] = ctrl.Rule(interest_rate['high'] & fees['medium'] & loan_term['long'] & bank_reputation['medium'], bank_score['average'])
rules[71] = ctrl.Rule(interest_rate['high'] & fees['medium'] & loan_term['long'] & bank_reputation['high'], bank_score['average'])
rules[72] = ctrl.Rule(interest_rate['high'] & fees['high'] & loan_term['short'] & bank_reputation['low'], bank_score['bad'])
rules[73] = ctrl.Rule(interest_rate['high'] & fees['high'] & loan_term['short'] & bank_reputation['medium'], bank_score['average'])
rules[74] = ctrl.Rule(interest_rate['high'] & fees['high'] & loan_term['short'] & bank_reputation['high'], bank_score['average'])
rules[75] = ctrl.Rule(interest_rate['high'] & fees['high'] & loan_term['medium'] & bank_reputation['low'], bank_score['bad'])
rules[76] = ctrl.Rule(interest_rate['high'] & fees['high'] & loan_term['medium'] & bank_reputation['medium'], bank_score['average'])
rules[77] = ctrl.Rule(interest_rate['high'] & fees['high'] & loan_term['medium'] & bank_reputation['high'], bank_score['average'])
rules[78] = ctrl.Rule(interest_rate['high'] & fees['high'] & loan_term['long'] & bank_reputation['low'], bank_score['bad'])
rules[79] = ctrl.Rule(interest_rate['high'] & fees['high'] & loan_term['long'] & bank_reputation['medium'], bank_score['average'])
rules[80] = ctrl.Rule(interest_rate['high'] & fees['high'] & loan_term['long'] & bank_reputation['high'], bank_score['average'])

# Добавление правил в систему
bank_ctrl = ctrl.ControlSystem(rules)

# Создание системы управления
bank = ctrl.ControlSystemSimulation(bank_ctrl)

# Пример ввода
bank.input['InterestRate'] = 3
bank.input['Fees'] = 4
bank.input['LoanTerm'] = 7
bank.input['BankReputation'] = 2

# Вычисление результатов
bank.compute()

# Вывод результата
print(f"Bank Score: {bank.output['BankScore']}")

# Визуализация
interest_rate.view()
fees.view()
loan_term.view()
bank_reputation.view()
bank_score.view(sim=bank)
plt.show()