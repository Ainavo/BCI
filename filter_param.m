
%% 对数据进行滤波
%输入：data 待滤波EEG数据
%   low        高通滤波参数设置
%   high       低通滤波参数设置
%   sampleRate          采样率
%   filterorder  butterworth滤波器阶数
%返回：filterdata       滤波后EEG数据
function filterdata=filter_param(data,low,high,sampleRate,filterorder)
%% 设置滤波参数
 filtercutoff = [low*2/sampleRate high*2/sampleRate]; %简单注释：频率/(采样频率/2=奈奎斯特频率)
 [filterParamB, filterParamA] = butter(filterorder,filtercutoff);%(求滤波器参数)
 filterdata= filter( filterParamB, filterParamA, data);
