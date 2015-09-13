<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>后台管理|七联就职</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" href="/appointment/css/bootstrap.min.css" media="screen">
    <link rel="stylesheet" href="/appointment/css/style.css" media="screen">
    <link rel="stylesheet" href="/appointment/css/qilian.css" media="screen">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <script src="/appointment/js/jquery-1.10.2.min.js"></script>
    <link rel="icon" href="/favicon.ico" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="/js/html5shiv.js"></script>
      <script src="/js/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    <!-- TopNav -->
    <?php echo $this->element('header-admin');?>
    <!-- /TopNav -->

    <div class="container page-header">

      <!-- main -->
      <div class="row clearfix page-header" id="main">

        <div class="col-lg-9" id="main-left">
          <?php if(isset($breadcrumbs)):?>
           <!-- breadcrumb -->
          <?php echo $this->element('breadcrumbs'); ?>
          <!-- /breadcrumb -->
          <?php endif;?>

          <?php echo $this->Session->flash(); ?>
          <?php echo $this->fetch('content'); ?>

        </div><!-- /main-left -->

        <!-- main-right sidebar -->
        <?php echo $this->element('sidebar-admin');?>
        <!-- /main-right sidebar -->

      </div><!-- /main-->

    </div>
    <?php echo $this->element('footer'); ?>
    <script src="/appointment/js/bootstrap.min.js"></script>
    <?php echo $this->element('sql_dump'); ?>
</body>
</html>
