<?php
/*
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC. All rights reserved.                        |
 |                                                                    |
 | This work is published under the GNU AGPLv3 license with some      |
 | permitted exceptions and without any warranty. For full license    |
 | and copyright information, see https://civicrm.org/licensing       |
 +--------------------------------------------------------------------+
 */

/**
 * @group headless
 */
class CRM_Core_InvokeTest extends CiviUnitTestCase {

  /**
   * Test that no php errors come up invoking dashboard url for non-admins
   * Motivation: This currently fails on php 7.4 because of IDS and magicquotes.
   */
  public function testInvokeDashboardForNonAdmin(): void {
    CRM_Core_Config::singleton()->userPermissionClass->permissions = ['access CiviCRM'];

    $_SERVER['REQUEST_URI'] = 'civicrm/dashboard?reset=1';
    $_GET['q'] = 'civicrm/dashboard';

    $item = CRM_Core_Invoke::getItem(['civicrm/dashboard?reset=1']);
    ob_start();
    CRM_Core_Invoke::runItem($item);
    ob_end_clean();
  }

  /**
   * Test dashboard with something actually on it.
   */
  public function testInvokeDashboardWithGettingStartedDashlet(): void {
    $user_id = $this->createLoggedInUser();
    $this->callAPISuccess('DashboardContact', 'create', [
      'dashboard_id' => 2,
      'contact_id' => $user_id,
    ]);

    CRM_Core_Config::singleton()->userPermissionClass->permissions = ['access CiviCRM'];

    $_SERVER['REQUEST_URI'] = 'civicrm/dashboard?reset=1';
    $_GET['q'] = 'civicrm/dashboard';

    $item = CRM_Core_Invoke::getItem(['civicrm/dashboard?reset=1']);
    ob_start();
    CRM_Core_Invoke::runItem($item);
    ob_end_clean();
  }

  public function testOpeningSearchBuilder(): void {
    $_SERVER['REQUEST_URI'] = 'civicrm/contact/search/builder?reset=1';
    $_GET['q'] = 'civicrm/contact/search/builder';
    $_GET['reset'] = 1;

    $item = CRM_Core_Invoke::getItem([$_GET['q']]);
    ob_start();
    CRM_Core_Invoke::runItem($item);
    $contents = ob_get_clean();

    unset($_GET['reset']);
    $this->assertRegExp('/form.+id="Builder" class="CRM_Contact_Form_Search_Builder/', $contents);
  }

  public function testContactSummary(): void {
    $cid = $this->individualCreate([
      'first_name' => 'ContactPage',
      'last_name' => 'Summary',
      'do_not_phone' => 1,
      'gender_id' => 'Male',
    ]);
    $_SERVER['REQUEST_URI'] = "civicrm/contact/view?cid={$cid}&reset=1";
    $_GET['q'] = 'civicrm/contact/view';
    $_GET['reset'] = $_REQUEST['reset'] = 1;
    $_GET['cid'] = $_REQUEST['cid'] = $cid;

    $item = CRM_Core_Invoke::getItem([$_GET['q']]);
    ob_start();
    CRM_Core_Invoke::runItem($item);
    $contents = ob_get_clean();

    unset($_GET['q'], $_REQUEST['q']);
    unset($_GET['reset'], $_REQUEST['reset']);
    unset($_GET['cid'], $_REQUEST['cid']);

    $this->assertStringContainsString("<div class=\"crm-content crm-contact_type_label\">\n      Individual\n    </div>", $contents);
    $this->assertStringContainsString("<div class=\"crm-content crm-contact-privacy_values font-red upper\">\n                  Do not phone<br/>                                                                                              </div>", $contents);
    $this->assertStringContainsString("<div class=\"crm-content crm-contact-gender_display\">Male</div>", $contents);
  }

}
