function perform_index_generation_yml(fileout, repin)

if nargin<1
    fileout = '../../../numerical-tours-site/_data/tours.yml';
end
if nargin<2
    repin = '../';
end

fid = fopen(fileout, 'wt');
if fid<=0
    error('Unable to open file');
end

list_ext = {...
       {'introduction'  'Introduction'} ...
       {'wavelet' 'Wavelet Processing'} ... 
       {'coding'  'Approximation, Coding and Compression'} ... 
       {'denoisingsimp'  'Simple Denoising Methods'} ...  
       {'denoisingwav'  'Wavelet Denoising'} ...  
       {'denoisingadv'  'Advanced Denoising Methods'} ...  
       {'audio' 'Audio Processing'} ...  
       {'multidim' 'Higher Dimensional Signal Processing'} ... 
       {'graphics' 'Computer Graphics'} ... 
       {'optim' 'Optimization'} ...
       {'optimaltransp' 'Optimal Transport'} ...
       {'sparsity' 'Sparsity and Redundant Representations'} ... 
       {'inverse' 'Inverse Problems'} ... 
       {'fastmarching' 'Geodesic Processing'} ...
       {'shapes' 'Shapes'} ...
       {'meshproc' 'Mesh Processing'} ... 
       {'meshdeform' 'Mesh Parameterization and Deformation'} ... 
       {'meshwav' 'Multiscale Mesh Processing'} ... 
    };
        % {'cs' 'Compressive Sensing'} ... 
        % {'numerics' 'Numerical Analysis'} ... 
%       {'variational' 'Variational Image Processing'}  ... 

pr = @(x)fprintf(fid,[x '\n']);
prL = @()fprintf(fid, '\n');

%%% GENERATE SECTIONS %%%
for iext = 1:length(list_ext)
    ext = list_ext{iext}{1};
    tit = list_ext{iext}{2};
    
    % print new category
    pr(['- name: ' tit]);
    pr(['  short: ' ext]);
    pr(['  list: ']);
    
    a = dir([repin ext '_*.m']);
    % print each tour with matching extension
    for k=1:length(a)
        tourname = a(k).name;
        fidt = fopen([repin tourname]);
        L = fgets(fidt);
        L = strtrim(strrep(L, '%% ', ''));
        fclose(fidt);
        % print name and directory
        pr(['  - name: ' L]);
        pr(['    rep: ' tourname(1:end-2)]);
    end
    prL();
end


fclose(fid);

