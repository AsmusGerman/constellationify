function show(instance)
   imshow(instance.image);
    
    %get every star center
    centers = instance.centers();

    %every star radius = 5
    viscircles(centers, 5,'EdgeColor','b');

    %centroid radius = 2
    viscircles(instance.centroid, 2,'EdgeColor','r');
end