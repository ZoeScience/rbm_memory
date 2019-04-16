function X = logsigm(P)
    X = log(1./(1+exp(-P)));
end