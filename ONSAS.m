% ==============================================================================
% --------     ONSAS: an Open Non-linear Structural Analysis System     --------
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

% ==============================================================================


% ==============================================================================
% ----------------------------     Input       ---------------------------------

ONSASversion = '0.1.10' ;

addpath( [ pwd '/sources' ] ) ;
addpath( [ pwd '/input'   ] ) ;
addpath( [ pwd '/user'    ] ) ;

if plotParamsVector(1)>0
  fprintf('==============================================\n');
  fprintf( [ 'Welcome to ONSAS v' ONSASversion '.\n' ] )
  fprintf('==============================================\n');
  fprintf( [ 'Copyright (C) 2019, Jorge M. Pérez Zerpa, J. Bruno Bazzano, Jean-Marc Battini, Joaquín Viera, Mauricio Vanzulli \n' ] ) ;
  fprintf( [ 'This program comes with ABSOLUTELY NO WARRANTY. \n' ] ) ;
  fprintf( [ 'This is free software, and you are welcome to redistribute it under certain conditions; read COPYNG file for more details. \n' ] ) ;
end

tReadingInput = 0;

% verifies the definition of input variables and sets default values
inputVarsVerification

inputAuxDefinitions

% ==============================================================================


% ==============================================================================
% ----------------------------    Analysis     ---------------------------------

if nonLinearAnalysisBoolean == 0 && dynamicAnalysisBoolean == 0
	
  % Linear Analysis
  linearAnalysis
  
  if LBAAnalyFlag == 1
    linearBucklingAnalysis
  end

else
  % --- Incremental steps analysis ---

  % Initial computations: sets initial matrices and vectors.
  initialDefinitions

  % --- increment step analysis ---
  while ( stopTimeIncrBoolean == 0 )
		tic ;
    % --------   computes the model state at the next load/time step   --------
    [modelNextState, BCsNextState, auxIO] = callSolver( modelCurrState, BCsNextState, auxIO);
    % -------------------------------------------------------------------------
		tCallSolver = toc ;
    % checks stopping criteria and stores model state
    storesResultAndCheckStopCrit
  end
  % -------------------------------
end

% if analytical solution is provided, numerical results are validated. 
if analyticSolFlag > 0
  analyticSolVerif ...
( analytSol, analyticFunc, loadFactors, controlDisps, timesVec, ...
analyticCheckTolerance, analyticSolFlag, problemName, printflag, outputdir );

end

if nonLinearAnalysisBoolean == 1 && ( numericalMethodParams(1) == 2 || numericalMethodParams(1) == 1 )
  timeIncr = 1;
end
% ==============================================================================


% ==============================================================================
% ----------------------------     Output      ---------------------------------

% plots and/or visualization files are generated
if plotParamsVector(1) > 0
  [ tDefShape, tLoadFac, tNormalForce, tLoadDisps, ...
		tVtkWriter, tVtkConecNodes ] = outputPlots( matUts, coordsElemsMat, plotParamsVector, ...
    Conec, Nodes, constantFext, variableFext, strucsize, controlDisps, ...
    visualloadfactor, linearDeformedScaleFactor, printflag, ...
    outputdir, problemName, loadFactors, sectPar, ...
    nonLinearAnalysisBoolean, dynamicAnalysisBoolean, dispsElemsMat, ...
    timeIncr, cellStress, matNts, indexesElems, plotsViewAxis ) ;
end

tic
% report with results is generated
if reportBoolean
  if nelems < 500
    if nnodes < 53
      outputReport
    end  
  end  
end
tReport = toc ;

noErrorsOccurred = 1 ;
% ==============================================================================
