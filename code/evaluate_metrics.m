function [acc, MCC, Fscore, Precision, Recall] = evaluate_metrics(y_true, y_pre)
    % 计算混淆矩阵元素
    TP = sum((y_true == 1) & (y_pre == 1));
    TN = sum((y_true == 0) & (y_pre == 0));
    FP = sum((y_true == 0) & (y_pre == 1));
    FN = sum((y_true == 1) & (y_pre == 0));

    % 计算准确率 (Accuracy)
    acc = (TP + TN) / (TP + TN + FP + FN);

    % 计算精度 (Precision)
    Precision = TP / (TP + FP);

    % 计算召回率 (Recall)
    Recall = TP / (TP + FN);

    % 计算F1得分 (F1 Score)
    Fscore = 2 * (Precision * Recall) / (Precision + Recall);

    % 计算马修斯相关系数 (MCC)
    MCC = (TP * TN - FP * FN) / sqrt((TP + FP) * (TP + FN) * (TN + FP) * (TN + FN));
end
