# -*- coding:utf-8 -*-

#%% 
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from scipy import stats

from sklearn.datasets import load_boston
import scipy.io as scio

boston = load_boston()

# scio.savemat(r'D:\다른사람참고_repos\MATLAB_Jungsuk\quzi12\boston.mat',mdict = {'boston': boston})

#%% 

bostonDF = pd.DataFrame(boston.data, columns = boston.feature_names)
bostonDF['PRICE'] = boston.target

bostonDF.head()

#%% regplot 이용한 시각화
fig, axs = plt.subplots(figsize=(16,8), ncols = 4, nrows = 2)
lm_features = ['RM', 'ZN', 'INDUS', 'NOX','AGE', 'PTRATIO', 'LSTAT', 'RAD']
for i, feature in enumerate(lm_features):
    row = int(i/4)
    col = i%4

    sns.regplot(x = feature, y = 'PRICE', data = bostonDF, ax = axs[row][col])

# %% 선형회귀 모델 만들어 집 가격 예측
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score

y_target = bostonDF['PRICE']
X_data = bostonDF.drop(['PRICE'], axis =1, inplace = False)

X_train, X_test, y_train, y_test = train_test_split(X_data, y_target, test_size = 0.3,
    random_state = 156)

# 선형회귀 OLS로 학습/예측/평가 수행.

lr = LinearRegression()
lr.fit(X_train, y_train)

y_preds = lr.predict(X_test)
mse = mean_squared_error(y_test, y_preds)

rmse = np.sqrt(mse)

print('MSE : {0:.3f}, RMSE: {1:.3f}'.format(mse, rmse))
print('Variance score : {0:.3f}'.format(r2_score(y_test, y_preds)))

# %%

plt.figure()
plt.plot(y_test, y_preds, 'o')

#%% 절편과 slope 확인하기

print('절편 값', lr.intercept_)
print('회귀 계수 값', np.round(lr.coef_, 1))

# 회귀 계수 값을 큰 값 순으로 정렬하기 위해 Series로 생성, 인덱스 칼럼명에 유의
coef = pd.Series(data = np.round(lr.coef_, 1), index = X_data.columns)
coef.sort_values(ascending = False)

#%% Cross Validation 수행

from sklearn.model_selection import cross_val_score

y_target = bostonDF['PRICE']
X_data = bostonDF.drop(['PRICE'], axis = 1, inplace = False)
lr = LinearRegression()

neg_mse_scores = cross_val_score(lr, X_data, y_target, scoring = "neg_mean_squared_error", cv = 5)
rmse_scores = np.sqrt(-1  * neg_mse_scores)
avg_rmse = np.mean(rmse_scores)

print('5 folds 의 개별 Negative MSE scores:', np.round(neg_mse_scores, 2))
print('5 folds 의 개별 RMSE scores: ', np.round(rmse_scores,2))
print('5 folds의 평균 RMSE: {0: .3f}'.format(avg_rmse))