/**
 * Copyright 2011 John Moore, Scott Gilroy
 *
 * This file is part of CollaboRhythm.
 *
 * CollaboRhythm is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation, either version 2 of the License, or (at your option) any later
 * version.
 *
 * CollaboRhythm is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with CollaboRhythm.  If not, see
 * <http://www.gnu.org/licenses/>.
 */
package collaboRhythm.shared.model.healthRecord
{

    import collaboRhythm.shared.model.Account;
    import collaboRhythm.shared.model.Record;

    import org.indivo.client.IndivoClientEvent;

    public class EquipmentHealthRecordService extends PhaHealthRecordServiceBase
	{
        // Indivo Api calls used in this healthRecordService
        public static const GET_EQUIPMENT_REPORT:String = "Get MedicationOrders Report";
        public static const GET_EQUIPMENTCHEDULEITEMS_REPORT:String = "Get MedicationScheduleItems Report";

        private var _apiCallsCompleted:int;
        	
		public function EquipmentHealthRecordService(consumerKey:String, consumerSecret:String, baseURL:String, account:Account)
		{
			super(consumerKey, consumerSecret, baseURL, account);
		}

        public function getEquipment(record:Record):void
        {
            _apiCallsCompleted = 0;

            var healthRecordServiceRequestDetails:HealthRecordServiceRequestDetails = new HealthRecordServiceRequestDetails(GET_EQUIPMENT_REPORT, null, record);
            _pha.reports_minimal_X_GET(null, null, null, null, record.id, "equipment", _activeAccount.oauthAccountToken, _activeAccount.oauthAccountTokenSecret, healthRecordServiceRequestDetails);
            healthRecordServiceRequestDetails = new HealthRecordServiceRequestDetails(GET_EQUIPMENTCHEDULEITEMS_REPORT, null, record);
            _pha.reports_minimal_X_GET(null, null, null, null, record.id, "equipmentscheduleitems", _activeAccount.oauthAccountToken, _activeAccount.oauthAccountTokenSecret, healthRecordServiceRequestDetails);
        }

        protected override function handleResponse(event:IndivoClientEvent, responseXml:XML, healthRecordServiceRequestDetails:HealthRecordServiceRequestDetails):void
        {
            _apiCallsCompleted += 1;

            if (healthRecordServiceRequestDetails.indivoApiCall == GET_EQUIPMENT_REPORT)
            {
                healthRecordServiceRequestDetails.record.equipmentModel.equipmentReportXml = responseXml;
            }
            else if (healthRecordServiceRequestDetails.indivoApiCall == GET_EQUIPMENTCHEDULEITEMS_REPORT)
            {
                healthRecordServiceRequestDetails.record.equipmentModel.equipmentScheduleItemsReportXml = responseXml;
            }

            if (_apiCallsCompleted == 2)
            {
                dispatchEvent(new HealthRecordServiceEvent(HealthRecordServiceEvent.COMPLETE));
            }
        }
	}
}