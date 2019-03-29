function signature()
    signature0 = fileread('signature.0.txt');
    signature1 = fileread('signature.1.txt');

    for index = 1:10
        clc;
        if rem(index, 2) == 0
            disp(signature0);
        else
            disp(signature1);
        end
        pause(0.2);
    end
end