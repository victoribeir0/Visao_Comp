load('train.mat');
label = train(1:60000,1);

q = 1; w = 1; e = 1; r = 1; t = 1; y = 1; u = 1; i = 1; o = 1; p = 1;

for d = 1:60000
    if (label(d) == 0)
        dig0(q,:) = train(d,2:785);
        q = q + 1;
    end
    
    if (label(d) == 1)
        dig1(w,:) = train(d,2:785);
        w = w + 1;
    end
    
    if (label(d) == 2)
        dig2(e,:) = train(d,2:785);
        e = e + 1;
    end
    
    if (label(d) == 3)
        dig3(r,:) = train(d,2:785);
        r = r + 1;
    end
    
    if (label(d) == 4)
        dig4(t,:) = train(d,2:785);
        t = t + 1;
    end
    
    if (label(d) == 5)
        dig5(y,:) = train(d,2:785);
        y = y + 1;
    end
    
    if (label(d) == 6)
        dig6(u,:) = train(d,2:785);
        u = u + 1;
    end
    
    if (label(d) == 7)
        dig7(i,:) = train(d,2:785);
        i = i + 1;
    end
    
    if (label(d) == 8)
        dig8(o,:) = train(d,2:785);
        o = o + 1;
    end
    
    if (label(d) == 9)
        dig9(p,:) = train(d,2:785);
        p = p + 1;
    end
end
