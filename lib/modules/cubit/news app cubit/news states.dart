abstract class NewsStates {}

class InitialStates extends NewsStates {}

class GetBusinessDataStates extends NewsStates {}

class GetErrorBusinessDataStates extends NewsStates {}

class GetScienceDataStates extends NewsStates {}

class GetErrorScienceDataStates extends NewsStates {}

class GetSportsDataStates extends NewsStates {}

class GetErrorSportsDataStates extends NewsStates {}

class GetSearchDataStates extends NewsStates {}

class GetErrorSearchDataStates extends NewsStates {}


class ChangeCurrentPageState extends NewsStates {}

class ChangeModeState extends NewsStates {}