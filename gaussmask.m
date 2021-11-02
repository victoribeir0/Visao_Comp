function mh = gaussmask()
%mh = [0.012841 0.026743 0.03415 0.026743 0.012841; 0.026743 0.055697 0.071122 0.055697 0.026743; 0.03415 0.071122 0.090818 0.071122 0.03415; 0.026743 0.055697 0.071122 0.055697 0.026743; 0.012841 0.026743 0.03415 0.026743 0.012841];
% mh = [0.077847	0.123317	0.077847;
% 0.123317	0.195346	0.123317;
% 0.077847	0.123317	0.077847]; %s=1 t=3

% mh = [0.077847	0.123317	0.077847;
% 0.123317	0.195346	0.123317;
% 0.077847	0.123317	0.077847]; % s=2 t=3

mh = (1/159)*[2 4 5 4 2; 4 9 12 9 4; 5 12 15 12 5; 4 9 12 9 4; 2 4 5 4 2];

end