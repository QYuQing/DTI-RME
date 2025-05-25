function [acc, MCC, Fscore, Precision, Recall] = evaluate_metrics(y_true, y_pre)
    % �����������Ԫ��
    TP = sum((y_true == 1) & (y_pre == 1));
    TN = sum((y_true == 0) & (y_pre == 0));
    FP = sum((y_true == 0) & (y_pre == 1));
    FN = sum((y_true == 1) & (y_pre == 0));

    % ����׼ȷ�� (Accuracy)
    acc = (TP + TN) / (TP + TN + FP + FN);

    % ���㾫�� (Precision)
    Precision = TP / (TP + FP);

    % �����ٻ��� (Recall)
    Recall = TP / (TP + FN);

    % ����F1�÷� (F1 Score)
    Fscore = 2 * (Precision * Recall) / (Precision + Recall);

    % ��������˹���ϵ�� (MCC)
    MCC = (TP * TN - FP * FN) / sqrt((TP + FP) * (TP + FN) * (TN + FP) * (TN + FN));
end
