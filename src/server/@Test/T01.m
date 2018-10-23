function output = T01()
  % nothing here yet...
end

%  function [distances, index] = T01(file, constellations, nAngles, nProportions)
%      
%      %test image
%      test = constellation(file, 'test');
%      test.features = ALR3(test, nAngles, nProportions);
%      
%      % images directory
%      %dir = './assets/images/';
%      %get all the constellations
%      %constellations = constellationify(dir, nAngles, nProportions);
%
%      euclidiana = @(A,B) sqrt(sum((double(A) - double(B)).^2));
%
%      
%      constellations(1).features
%      for i = 1 : length(constellations)
%        distances(i) = bsxfun(euclidiana, test.features, constellations(i).features)
%      end
%      
%      [distances, index] = sort(distances);
%  end