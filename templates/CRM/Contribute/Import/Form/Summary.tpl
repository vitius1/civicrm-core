{*
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC. All rights reserved.                        |
 |                                                                    |
 | This work is published under the GNU AGPLv3 license with some      |
 | permitted exceptions and without any warranty. For full license    |
 | and copyright information, see https://civicrm.org/licensing       |
 +--------------------------------------------------------------------+
*}
{* Contribution Import Wizard - Step 4 (summary of import results AFTER actual data loading) *}
{* @var $form Contains the array for the form elements and other form associated information assigned to the template by the controller *}
<div class="crm-block crm-form-block  crm-contribution-import-summary-form-block" id="upload-file">
 {* WizardHeader.tpl provides visual display of steps thru the wizard as well as title for current step *}
 {include file="CRM/common/WizardHeader.tpl"}

 <div class="help">
    <p>
    <strong>{ts}Import has completed successfully.{/ts}</strong> {ts}The information below summarizes the results.{/ts}
    </p>

    {if $invalidRowCount }
        <p class="error">
        {ts count=$invalidRowCount plural='CiviCRM has detected invalid data and/or formatting errors in %count records. These records have not been imported.'}CiviCRM has detected invalid data and/or formatting errors in one record. This record has not been imported.{/ts}
        </p>
        <p class="error">
        {ts 1=$downloadErrorRecordsUrl}You can <a href="%1">Download Errors</a>. You may then correct them, and import the new file with the corrected data.{/ts}
        </p>
    {/if}

    {if $duplicateRowCount}
        <p {if $dupeError}class="error"{/if}>
        {ts count=$duplicateRowCount plural='CiviCRM has detected %count records which are duplicates of existing CiviCRM contribution records.'}CiviCRM has detected one record which is a duplicate of existing CiviCRM contribution record.{/ts} {$dupeActionString}
        </p>
        <p {if $dupeError}class="error"{/if}>
        {ts 1=$downloadDuplicateRecordsUrl}You can <a href="%1">Download Duplicates</a>. You may then review these records to determine if they are actually duplicates, and correct the transaction IDs for those that are not.{/ts}
        </p>
    {/if}
 </div>
 <div class="crm-submit-buttons">{include file="CRM/common/formButtons.tpl" location="top"}</div>
 {* Summary of Import Results (record counts) *}
 <table id="summary-counts" class="report">
    <tr><td class="label crm-grid-cell">{ts}Total Rows{/ts}</td>
        <td class="data">{$totalRowCount}</td>
        <td class="explanation">{ts}Total rows (contribution records) in uploaded file.{/ts}</td>
    </tr>

    {if $invalidRowCount }
    <tr class="error"><td class="label crm-grid-cell">{ts}Invalid Rows (skipped){/ts}</td>
        <td class="data">{$invalidRowCount}</td>
        <td class="explanation">{ts}Rows with invalid data in one or more fields. These rows have been skipped (not imported).{/ts}
            {if $invalidRowCount}
                <p><a href="{$downloadErrorRecordsUrl}">{ts}Download Errors{/ts}</a></p>
            {/if}
        </td>
    </tr>
    {/if}

    {if $validSoftCreditRowCount }
    <tr><td class="label crm-grid-cell">{ts}Soft Credits{/ts}</td>
        <td class="data">{$validSoftCreditRowCount}</td>
        <td class="explanation">{ts}Rows where a soft credit was successfully assigned to a contact.{/ts}</td>
    </tr>
    {/if}

    {if $invalidSoftCreditRowCount }
    <tr class="error"><td class="label crm-grid-cell">{ts}Unmatched Soft Credit Rows (skipped){/ts}</td>
        <td class="data">{$invalidSoftCreditRowCount}</td>
        <td class="explanation">{ts}Rows with a requested soft credit assignment where no matching contact was found (based on the supplied soft credit contact data). These contribution rows have been skipped (not imported).{/ts}
            {if $invalidSoftCreditRowCount}
                <p><a href="{$downloadSoftCreditErrorRecordsUrl}">{ts}Download Errors{/ts}</a></p>
            {/if}
        </td>
    </tr>
    {/if}

    {if $validPledgePaymentRowCount }
    <tr><td class="label crm-grid-cell">{ts}Pledge Payments Applied{/ts}</td>
        <td class="data">{$validPledgePaymentRowCount}</td>
        <td class="explanation">{ts}Rows with a pledge payment successfully applied.{/ts}</td>
    </tr>
    {/if}

    {if $invalidPledgePaymentRowCount }
    <tr class="error"><td class="label crm-grid-cell">{ts}Invalid Pledge Payment Rows (skipped){/ts}</td>
        <td class="data">{$invalidPledgePaymentRowCount}</td>
        <td class="explanation">{ts}Rows marked as pledge payments where the contributor and / or contribution amount could not be matched to a pending pledge payment. These contribution rows have been skipped (not imported).{/ts}
            {if $invalidPledgePaymentRowCount}
                <p><a href="{$downloadPledgePaymentErrorRecordsUrl}">{ts}Download Errors{/ts}</a></p>
            {/if}
        </td>
    </tr>
    {/if}

    {if $duplicateRowCount}
    <tr class="error"><td class="label crm-grid-cell">{ts}Duplicate Rows{/ts}</td>
        <td class="data">{$duplicateRowCount}</td>
        <td class="explanation">{ts}Rows which are duplicates of existing CiviCRM contribution records.{/ts} {$dupeActionString}
            {if $duplicateRowCount}
                <p><a href="{$downloadDuplicateRecordsUrl}">{ts}Download Duplicates{/ts}</a></p>
            {/if}
        </td>
    </tr>
    {/if}

    <tr><td class="label crm-grid-cell">{ts}Records Imported{/ts}</td>
        <td class="data">{$validRowCount}</td>
        <td class="explanation">{ts}Total number of rows imported successfully.{/ts}</td>
    </tr>

 </table>
 <div class="crm-submit-buttons">{include file="CRM/common/formButtons.tpl" location="bottom"}</div>
 </div>
