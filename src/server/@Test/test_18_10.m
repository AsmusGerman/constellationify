function output = test_18_10()
  nAngles = 18;
  nProportions = 10;

  %the alr3 file for this test
  source = 'alr3_18_10';
  
  %if source file doesn't exists, run alr3 and save the file
  if(exist(strcat(source,'.mat')) ~= 2)
    constellations = Constellationify.import('constellations');
    constellations = Constellationify.runALR3(constellations, nAngles, nProportions);
    
    %save the alr3 result to an isolated file
    Constellationify.save(source, constellations);
  end

  files = Constellationify.read(Test.set, Test.extension);
  nFiles = length(files);

  output = Collection();
   
  %create the constellations
  for i = 1 : nFiles
      % get the file name and full name
      [name, url] = Constellationify.fileinfo(files(i).value);

      constellation = Constellation(url, name);
      constellation.features = ALR3.run(constellation, nAngles, nProportions);

      test.name = name;
      test.distances = Test.compare(constellation, Constellationify.import(source));

      output = output.add(test);
  end
  
  output = [output.value];
  Constellationify.save('@Test/test_18_10', output);
end