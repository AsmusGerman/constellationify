function output = A18P10()
  nAngles = 18;
  nProportions = 10;
  result = '@Test/TEST.A18P10';
  files = {'ara', 'canis_minor', 'crater', 'dorado', 'draco', 'lynx', 'scorpius', 'scutum', 'telescopium', 'vulpecula'};

  % load the constellations from the 'results' folder
  constellations = main(nAngles, nProportions);

  nFiles = length(files);
  output = Collection();
  
  %create the constellations
  for i = 1 : nFiles
      
      %getting the test constellation
      constellation = constellations(strcmp({constellations.name}, files(i)))
      test.name = files(i);
      test.distances = Test.compare(constellation, constellations);

      output = output.add(test);
  end
  
  output = [output.value];
  MatFileController.save('@Test/TEST.A18P10', output);
end