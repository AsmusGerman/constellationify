function output = cast(type, object)
    output = eval(type);  %create object
    for field = fieldnames(object)    %enumerat fields
        try
            output.(field{1}) = object.(field{1});   %and copy
        catch
            warning('Could not cast object field %s', field{1});
        end
    end
end