clear
MU = 0.005;GAMMA=0.002;
%% load adjacency matrix
dataname = 'e';
cv_type = 'CVP';
[y,~,~] = loadtabfile(['D:' dataname '_admat_dgc.txt']);

seed = 2024;
nfolds = 5;
nruns=20;
ratio = 5

[n,m] = size(y);
[crossval_idx] = fun_cross_idx(n,m,nfolds,seed,cv_type);
fold_aupr=[];fold_auc=[];fold_fscore=[];fold_precision=[];fold_recall=[];
for fold=1:nfolds
    %% split
    train_idx = find(crossval_idx~=fold);
    test_idx  = find(crossval_idx==fold);
    y_train = y;
    y_train(test_idx) = 0;
    num_zeros = sum(y(test_idx) == 0);
    num_ones = sum(y(test_idx) == 1);
    y_test = y(test_idx);
    ones_index = find(y_test==1);
    zero_index = find(y_test==0);
    ones_index = ones_index(1:num_ones);
    zero_index = zero_index(1:ratio*num_ones);
    test_idx = [test_idx(ones_index);test_idx(zero_index)];
    %% kernel
    k1_paths = {['' dataname '_simmat_proteins_sw-n.txt'],...
        ['D:/' dataname '_simmat_proteins_go.txt'],...
        ['D:/' dataname '_simmat_proteins_ppi.txt'],...
        };
    K1 = [];
    for i=1:length(k1_paths)
        [mat, ~] = loadtabfile(k1_paths{i});
        mat = process_kernel(mat);
        K1(:,:,i) = Knormalized(mat);
    end
    K1(:,:,3+1) = kernel_gip(y_train,1,0.5);
    K1(:,:,3+2) = Knormalized( kernel_cosine(y_train,1,MU,GAMMA) );
    K1(:,:,3+3) = Knormalized( kernel_corr(y_train,1,MU,GAMMA) );
    k2_paths = {['D:/' dataname '_simmat_drugs_simcomp.txt'],...
        ['D:/' dataname '_simmat_drugs_sider.txt'],...
        };
    K2 = [];
    for i=1:length(k2_paths)
        [mat, labels] = loadtabfile(k2_paths{i});
        mat = process_kernel(mat);
        K2(:,:,i) = Knormalized(mat);
    end
    gamma_fp = 4;
    load(['D:/' dataname '_Drug_MACCS_fingerprint.mat']);
    K2(:,:,i+1) = Knormalized( kernel_gip(Drug_MACCS_fingerprint,1, gamma_fp) );
    gamma=0.5;
    K2(:,:,3+1) = Knormalized( kernel_gip(y_train,2,gamma) );
    K2(:,:,3+2) = Knormalized( kernel_cosine(y_train,2,MU,GAMMA) );
    K2(:,:,3+3) = Knormalized( kernel_corr(y_train,2,MU,GAMMA) );
    %% DTI_RME
    lambda_1 = 0.03125;
    lambda_2 = 1;
    lambda_3 = 0.125;
    lambda_4 = 100;
    sita = 0.125;
    k = 80;
    [pre] = DTI_RME(K1,K2,y_train,sita,lambda_1,lambda_2,lambda_4,k,lambda_3);
    %% evaluate predictions
    yy=y;
    y_true = yy(test_idx);
    y_pre = pre(test_idx);
    [~,~,~,aupr] = perfcurve(y_true,y_pre,1, 'xCrit', 'reca', 'yCrit', 'prec');
    [~,~,~,auc,~,~,~] = perfcurve(y_true,y_pre,1);
    threshold = (max(y_pre) + min(y_pre)) / 2;
    y_pred_binary = y_pre >= threshold;
    [~, ~, Fscore, Precision, Recall] = evaluate_metrics(y_true, y_pred_binary);
    fold_aupr=[fold_aupr;aupr];
    fold_auc=[fold_auc;auc];
    fold_fscore = [fold_fscore,Fscore];
    fold_precision = [fold_precision,Precision];
    fold_recall = [fold_recall,Recall];
end
mean_aupr = mean(fold_aupr); mean_auc = mean(fold_auc);
fprintf('Finsh AUPR: %f AUC: %f \n', mean_aupr,mean_auc)
