import {
  NgForm,
  FormGroup,
  FormControl,
  Validators,
  FormBuilder,
  ReactiveFormsModule
} from '@angular/forms';
import * as moment from 'moment/moment';

export class PreOPPachymetryModel {
  public Id: number = 0;
  public MasterId: number = 0;
  public Profile: string = null;
  public PentMin: number = 0;
  public PentCentral: number = 0;
  public USMin: number = 0;
  public VisanteMin: number = 0;
  public CreatedBy: number = 0;
  public CreatedOn: Date = new Date();
  public IsOD: boolean;

  constructor() {

  }
  dateValidator(control: FormControl): { [key: string]: boolean } {
    var currDate = moment().format('YYYY-MM-DD HH:mm');
    if (control.value) { // gets empty string for invalid date such as 30th Feb or 31st Nov)
      if ((moment(control.value).diff(currDate) > 0)
        || (moment(currDate).diff(control.value, 'years') > 200)) //can select date upto 200 year past from today.
        return { 'wrongDate': true };
    }
    else
      return { 'wrongDate': true };
  }

}
