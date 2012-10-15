<?php
require_once __DIR__.'/../vendor/autoload.php';

error_reporting(E_ALL);
ini_set('display_errors','On');
$app = new Silex\Application();
$app['debug'] = true;

$app->register(new Silex\Provider\TwigServiceProvider(), array(
    'twig.path' => __DIR__.'/views',
));

use Silex\Provider\FormServiceProvider;
use Symfony\Component\HttpFoundation\Request;

$app->register(new FormServiceProvider());
$app->register(new Silex\Provider\TranslationServiceProvider(), array(
    'translator.messages' => array(),
));

$app->register(new Silex\Provider\DoctrineServiceProvider(), array(
    'db.options' => array(
        'driver'    => 'pdo_pgsql',
        'path'      => __DIR__.'/app.db',
        'host'      => '192.168.102.103',
        'dbname'    => 'wsip20120921',
        'user'      => 'postgres',
        'password'  => ''
    ),
));

$app->register(new Silex\Provider\UrlGeneratorServiceProvider());


$app->get('/',  function(Silex\Application $app) {

    $sql = 'SELECT * FROM deresze limit 20';
    $deresze = $app['db']->fetchAll($sql, array());
    
    return $app['twig']->render('layout.twig', array(
        'data' => $deresze,
    ));
})
->bind('homepage');


$app->get('/show/{id}', function($id) use($app) {
    $sql = 'SELECT * FROM deresze WHERE id = ?';
    $deresz = $app['db']->fetchAssoc($sql, array((int) $id));
    $deresz['content'] = json_decode($deresz['content']);
    
    return $app['twig']->render('show.twig', array(
        'item' => $deresz,
    ));
 })
 ->bind('show');
 
$app->match('/nowyDeresz', function (Request $request) use ($app) {
        // some default data for when the form is displayed the first time
        $data = array(
            'title' => 'Tytuł',
            'author' => 'Autor',
            'content1' => 'Tekst1',
            'content2' => 'Tekst2',
            'content3' => 'Tekst3'
        );

        $form = $app['form.factory']->createBuilder('form', $data)
            ->add('title')
            ->add('author')
            ->add('content1')
            ->add('content2')
            ->add('content3')
            ->getForm();

        if ('POST' == $request->getMethod()) {
            $form->bind($request);

            if ($form->isValid()) {
                $data = $form->getData();
                
                $content = array($data['content1'], $data['content2'], $data['content3']);
                $data['content'] = json_encode($content);
                unset($data['content1']);
                unset($data['content2']);
                unset($data['content3']);
                
                $app['db']->insert('deresze', $data);
                // do something with the data

                // redirect somewhere
                return $app->redirect('.');
            }
        }

        // display the form
        return $app['twig']->render('new.twig', array('nowyDeresz' => $form->createView()));
})
->bind('new');

$app->run();
