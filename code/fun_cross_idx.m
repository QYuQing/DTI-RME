function [crossval_idx] = fun_cross_idx(n,m,nfolds,seed,cv_type)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
rand('seed', seed);
if strcmp(cv_type, 'CVP')
    crossval_idx = crossvalind('Kfold',n*m,nfolds);
elseif strcmp(cv_type, 'CVT')
    crossval_idx = crossvalind('Kfold',n,nfolds);
    crossval_idx = repmat(crossval_idx,1,m);
elseif strcmp(cv_type, 'CVD')
    crossval_idx = crossvalind('Kfold',m,nfolds);
    crossval_idx = repmat(crossval_idx',n,1);
else 
    crossval_idx = 0;
end    
end

