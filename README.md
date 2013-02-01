VW-NHL-Rank
===========

VW-Ranking

Toy example for predicting overall point totals (goals + assists) for players in the 2011-2012 season using data 
from 2010-2011 to train the models.  Explores 2 approaches.  The first uses SGD regression to predict point totals
and then uses this prediction to find player rank.  The accuracy of the prediction is then measured using MAP from 
the R 'Metrics' package.  The second approach uses error correcting tournament to assign ranks based on multiple
binary tournaments between sample rows.  The players are then ranked according to the number of binary tournaments
they win.

The data is from these 2 sites:

http://www.hockey-reference.com/leagues/NHL_2011_skaters.html

http://www.hockey-reference.com/leagues/NHL_2012_skaters.html


Vowpal Wabbit Install Info:

https://github.com/JohnLangford/vowpal_wabbit/wiki/Tutorial

VW has several dependencies.  If you are having trouble getting VW to work check that all updates are installed and
the boost library is installed (instructions for boost are on the VW wiki).  
