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
package collaboRhythm.core.model.healthRecord.service
{

	import collaboRhythm.core.model.healthRecord.Schemas;
	import collaboRhythm.shared.model.Account;
	import collaboRhythm.shared.model.healthRecord.*;
	import collaboRhythm.shared.model.healthRecord.document.MedicationFill;

	public class MedicationFillsHealthRecordService extends DocumentStorageSingleReportServiceBase
	{
		public function MedicationFillsHealthRecordService(consumerKey:String, consumerSecret:String, baseURL:String,
													 account:Account)
		{
			super(consumerKey, consumerSecret, baseURL, account,
				  MedicationFill.DOCUMENT_TYPE, MedicationFill, Schemas.MedicationFillSchema, "medicationfills");
		}

		override protected function documentShouldBeIncluded(document:IDocument, nowTime:Number):Boolean
		{
			var medicationFill:MedicationFill = document as MedicationFill;
			return medicationFill.dateFilled == null || medicationFill.dateFilled.valueOf() <= nowTime;
		}
	}
}