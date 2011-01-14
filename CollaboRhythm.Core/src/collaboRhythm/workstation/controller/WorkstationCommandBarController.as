package collaboRhythm.workstation.controller
{
	import collaboRhythm.workstation.model.Settings;
	import collaboRhythm.workstation.model.User;
	import collaboRhythm.workstation.model.UsersModel;
	import collaboRhythm.workstation.model.WorkstationCommandBarModel;
	import collaboRhythm.workstation.model.services.ICurrentDateSource;
	import collaboRhythm.workstation.model.services.WorkstationKernel;
	import collaboRhythm.workstation.view.WorkstationCommandBarView;
	
	import flash.events.EventDispatcher;
	
	import mx.core.IVisualElementContainer;
	import mx.effects.Move;
	import mx.events.EffectEvent;
	
	import spark.components.Group;
	import spark.effects.Resize;

	/**
	 * 
	 * @author jom
	 * 
	 * Coordinates interactions between the WorkstationCommandBarView and the UserModel classes.
	 * Currently, this simply includes setting the remoteUser currently active in the workstationCommandBarView.  
	 * It dispatches an event for sending a collaboration request that is listened for by the CollaborationMediator in order to coordinate interaction with the RemoteUserController. 
	 * 
	 */
	public class WorkstationCommandBarController extends EventDispatcher
	{
		private var _workstationCommandBarView:WorkstationCommandBarView;
		private var _usersModel:UsersModel;
		private var _remoteUser:User;
		private var _currentDateSource:ICurrentDateSource;
		private var _model:WorkstationCommandBarModel;
		private var _settings:Settings;
		
		public function WorkstationCommandBarController(view:WorkstationCommandBarView, usersModel:UsersModel, settings:Settings)
		{
			_currentDateSource = WorkstationKernel.instance.resolve(ICurrentDateSource) as ICurrentDateSource;
			_settings = settings;

			_model = new WorkstationCommandBarModel();
			_model.currentDateSource = _currentDateSource;
			_model.subjectUser = remoteUser;
			_model.usersModel = usersModel;
			_model.allowCloseRecord = settings.isClinicianMode;
			
			_workstationCommandBarView = view;
			_workstationCommandBarView.y = _workstationCommandBarView.y - _workstationCommandBarView.height;
			_workstationCommandBarView.initializeController(this, _model);
			_usersModel = usersModel;
		}

		[Bindable]
		public function get remoteUser():User
		{
			return _remoteUser;
		}

		public function set remoteUser(value:User):void
		{
			_remoteUser = value;
			_model.subjectUser = _remoteUser;
			_model.allowCloseRecord = (_remoteUser != null && _settings.isClinicianMode);
		}
		
		public function get usersModel():UsersModel
		{
			return _usersModel;
		}

		public function closeRecord():void
		{
			if (_remoteUser != null)
				dispatchEvent(new CollaborationEvent(CollaborationEvent.CLOSE_RECORD, _remoteUser));
		}
		
		public function collaborateWithUser():void 
		{
			dispatchEvent(new CollaborationEvent(CollaborationEvent.COLLABORATE_WITH_USER, _remoteUser));
		}
		
		public function hideEndHandler(event:EffectEvent):void
		{
			dispatchEvent(new CollaborationEvent(CollaborationEvent.RECORD_CLOSED, _remoteUser));
		}
		
		public function hide():void
		{		
			_workstationCommandBarView.hideEffect.play();	
		}
		
		public function show():void
		{
			_workstationCommandBarView.validateNow();
			_workstationCommandBarView.showEffect.play();	
		}
		
		public function get currentDateSource():ICurrentDateSource
		{
			return _currentDateSource;
		}
		
	}
}