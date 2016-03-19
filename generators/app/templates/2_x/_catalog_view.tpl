<!-- Start <%= titleized_name %> module -->
<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content" style="text-align: center;">
  <?php if ($customers) { ?>
    <table cellpadding="2" cellspacing="0" style="width: 100%;">
      <?php foreach ($customers as $customer) { ?>
      <tr><td valign="top"><?php echo $customer['firstname']; ?></td></tr>
      <?php } ?>
    </table>
    <?php } ?>
  </div>
</div>
<!-- End <%= titleized_name %> module -->