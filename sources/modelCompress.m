%~ Copyright (C) 2019, Jorge M. Pérez Zerpa, J. Bruno Bazzano, Jean-Marc Battini, Joaquín Viera, Mauricio Vanzulli  

%~ This file is part of ONSAS.

%~ ONSAS is free software: you can redistribute it and/or modify
%~ it under the terms of the GNU General Public License as published by
%~ the Free Software Foundation, either version 3 of the License, or
%~ (at your option) any later version.

%~ ONSAS is distributed in the hope that it will be useful,
%~ but WITHOUT ANY WARRANTY; without even the implied warranty of
%~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%~ GNU General Public License for more details.

%~ You should have received a copy of the GNU General Public License
%~ along with ONSAS.  If not, see <https://www.gnu.org/licenses/>.


%function for storing solver's input data structures.
 
if dynamicAnalysisBoolean == 0
  modelCurrState = struct ( 'coordsElemsMat', coordsElemsMat,...
                            'Conec'         , Conec,...
                            'secGeomProps'  , secGeomProps, ...
                            'hyperElasParamsMat', hyperElasParamsMat, ...
                            'Ut'            , Ut, ...
                            'bendStiff'     , bendStiff, ...
                            'Strainst'      , Strainst,...
                             'Stresst'      , Stresst, ...
                             'FintGt'       , FintGt, ...
                             'nKeigneg'     , nKeigneg, ...
                             'nKeigpos'     , nKeigpos, ...
                             'factorCrit'   , factorCrit, ...
                             'convDeltau'   , convDeltau, ...
% variables to analyze if should be considered in struct
                            %~ 'Utp1'          , Utp1, ...
                             %~ 'dsigdepst'    , dsigdepst, ...
                             'nnodes'       , nnodes                 );
                             
                             
else
  modelCurrState = struct ( 'coordsElemsMat', coordsElemsMat,...
                            'dispsElemsMat' , dispsElemsMat,...
                            'Conec'         , Conec,...
                            'secGeomProps'  , secGeomProps, ...
                            'hyperElasParamsMat', hyperElasParamsMat, ...
                            'Ut'            , Ut, ...
                            'Udott'         , Udott, ...
                            'Udotdott'      , Udotdott, ...
                            'Stresst'       , Stresst, ...  %este no es calculado en el solver, se agerga?
                            'Strainst'      , Strainst,... %este no es calculado en el solver, se agerga?
                            'currTime'      , currTime,...
                             'FintGt'       , FintGt, ...
                             'convDeltau'   , convDeltau, ...
                             'nnodes'       , nnodes, ...
                             'ndofpnode'    , ndofpnode, ...
                             'nelems'       , nelems,...
                             'nodalDamping' , nodalDamping,...         
                             'deltamassMat' , deltamassMat        );

end

BCsNextState = struct ( 'constantFext'    , constantFext, ...
                        'loadFactorsFunc' , loadFactorsFunc, ...
                        'variableFext'    , variableFext, ...
                        'currLoadFactor'  , currLoadFactor, ...
                        'nextLoadFactor'  , nextLoadFactor, ...
                        'neumdofs'        , neumdofs, ...
                        'ndofpnode'       , ndofpnode, ...
                        'KS'              , KS       , ...
                        'userLoadsFilename', userLoadsFilename  );

auxIO = struct( 'numericalMethodParams' , numericalMethodParams, ...
                'dynamicAnalysisBoolean', dynamicAnalysisBoolean, ...
                'itersPerTime'          , itersPerTime, ...
                'stopCritPar'           , stopCritPar ) ;
